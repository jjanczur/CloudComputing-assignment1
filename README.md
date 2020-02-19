# CloudComputing-assignment1

This is the repo imported from TU Berlin GitLab with the code for the assignment 1 in Cloud Computing course. 

We got **maximum number of points**, so enjoy our work.    
If you found it useful, you can give us a star.

# Setup

To run benchmarks just run schedule-benchmarks.sh

Since the aim of the assignment is not to benchmark the google against amazon 
machines we decided to use the following setup:

* Google f1-micro
  * Disc type - HDD - 30 GB
  * Memory - 0,6 GB
  * CPU - Shared 0,2 virtual CPU
  * Zone - europe-west-3c
  * OS - centos-7
  * Virtualization - KVM (HW assisted)

* Amazon t2.micro
  * Disc type - SSD - 50 GB
  * Memory - 1 GB
  * CPU - 1 virtual CPU - 3.3 GHz Intel Scalable Processor
  * Region - eu-central-1
  * OS - Amazon Linux
  * Virtualization - HVM (HW assisted)

Both machines use HW assisted virtualization.


# CPU benchmark questions: 

## 1. Look at linpack.sh and linpack.c and shortly describe how the benchmark works. 
Linpack benchmark consists of the number of 64-bit floating-point operations, 
generally additions and multiplications, calculates FLOPS (Floating Point 
Operations Per Second) of computers by running the programs that solves dense 
system of linear equations. The output of the script is in KFLOPS (Kilo 
Floating-Point Operations Per Second) and its prints the result to machine 
precision.

The ideal test technique for the Linpack Benchmark is to run the same application on the systems being tested. Linpack benchmark reflects the performance of a dedicated system for solving a dense system of linear equations. Since the problem is very regular, the performance achieved is quite high, and the performance numbers give an excellent correction of peak performance.

## 2. Find out what the LINPACK benchmark measures (try Google). Would you expect paravirtualization to affect the LINPACK benchmark? Why? 
The LINPACK benchmark measures how fast a computer solves linear algebra calculations, LU decomposition, and solving a system of linear equations. Its results are returned in number of floating-point operations per second (FLOPS). 

As LINPACK Benchmark tasks involve only (most of the time) unprivileged instructions and are executed on the CPU of the system, we would not expect paravirtualization to affect the benchmark results, until the virtualized machine has dedicated access to the host's resources.

## 3. Look at your LINPACK measurements. Are they consistent with your expectations? If not, what could be the reason?

The measurements performed on Google f1-micro usually yielded results of about
2.37 GFLOPS, which was expected based on the specification of the machine.
The one outlier, a result of 2.25 GFLOPS happened on 2018-11-24 at 12:00:00.
The reason for that might have been increased load on the host machine at
that time, or some automatic system maintenance tasks. Overall the results
stay pretty consistent.

The results on AWS t2.micro are about 2.06 GFLOPS, which, again, matches our expectations based on the machine's specification. There are two outliers, one at the start of the benchmark and one near the end. The reasons for them are probably the same as described in the previous paragraph.


# Memory benchmark questions:

## 1. Find out how the memsweep benchmark works by looking at the shell script and the C code. Would you expect virtualization to affect the memsweep benchmark? 

Why?    
Memsweep Benchmark measures memory access performance. This benchmark measures the required time to access (write and clean) buffer memory in various locations. The step width between the consecutive accesses is chosen such that a cache miss occurs, and the data really has to be loaded from memory.

The memory pages should be already in RAM since the buffer is allocated before the measurement starts. That is why paravirtualization should not affect the memory benchmark.

In our case, both of the environments are based on hardware-assisted
virtualization, so we expect a noticeable effect on the memsweep benchmark because of the more complicated handling in the TLB: "Code violates locality assumption, lots of TLB misses - high-cost O(n^2), O(n) lookup cost."

AWS - ARR_SIZE (8192 * 16384)
Google - ARR_SIZE (8096 * 4096)

We were testing different sizes of the allocated heap and decided to use different values for AWS and google. For google 32 MB for AWS 128 MB. 

## 2. Look at your memsweep measurements. Are they consistent with your expectations? If not, what could be the reason?

Comparing the results between AWS and GCLOUD shows that the GCLOUD  machine is more than 2 times slower than the AWS machine even though the heap size is 4 times bigger for AWS. There's one outlier in the Google Cloud case. Such a significant slowdown could have been caused, for example, by a host system using swap memory. Otherwise the measurements are consistent within margin of error. The big difference between the results on Google and AWS is probably caused by the difference in the RAM speeds of the actual physical chips used.


# Disk benchmark questions: 

## 1. Look at the disk measurements. Are they consistent with your expectations? 
If not, what could be the reason? 

Our expectations based on the fact that in our case Google uses HDD and 
uses SSD disk and based on the documentation we expect that in case of 
HDD -  sequential access will be faster than the random, whereas in case 
amazon - SSD - there should not be any significant difference between 
and sequential access. 

In our case, disc measurements are consistent with our expectations.

Average time of RANDOM reading of 2048MB on GCLOUD: 22.28s
Average time of SEQUENTIAL reading of 2048MB on GCLOUD: 17.13s

Average time of RANDOM reading of 2048MB on EC2: 33.82
Average time of SEQUENTIAL reading of 2048MB on EC2: 34.21s

## 2. Compare the results for the two operations (sequential, random). What are the reasons for the differences?

The difference in benchmarks' results of sequential and random reads/writes from HDD disk comes from the higher number of seek operations needed for random reads. Seek operation is the most time consuming one during I/O process and takes place when a disk head is being positioned over the physical place, where the searched data is stored. For sequential read/write seek time is negligible since disk sectors, which are being read/written, are adjacent.
Such a situation does not occur in SSD disks, because seek time is very low. 
