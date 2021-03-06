# This script should be sourced from the WRF installation directory
export WRF_BUILD=/opt/gridware/apps/intel-15.0/WRF/3.8/ARW
wget http://www2.mmm.ucar.edu/wrf/src/WRFV3.8.TAR.gz
tar -xzf WRFV3.8.TAR.gz
cd WRFV3

module load compilers/intel/fortran/15.0.3
module load libs/intel-15.0/hdf/5/1.8.16
module load libs/intel-15.0/netcdf/4.4.0
module load libs/intel-15.0/zlib/1.2.8
module load mpi/intel-15.0/openmpi/1.8.3-ib

export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export JASPERLIB=/usr/lib64
export JASPERINC=/usr/include/jasper
export MPI_ROOT=/opt/gridware/mpi/intel/openmpi/1.8.3--intel-15.0.3

echo "Now configure using options 15. (dmpar) INTEL (ifort/icc)"
echo " and 1. Basic nesting"
./configure
# 15. (dmpar) INTEL (ifort/icc)
# 1. Basic nesting

echo "=================================================================="
echo "Now append flags to variables in configure.wrf"
echo "----------------------------------------------"
echo "In configure.wrf, append the flags: -msse2 -axSSE4.2,AVX,CORE-AVX2"
echo "to the following variables, so that WRF will run on any node:"
echo "	SFC"
echo "	SCC"
echo "	CCOMP"
echo "	CFLAGS_LOCAL"
echo "	FCOPTIM"
echo "=================================================================="
echo "Now compile WRF (before WPS)"
echo "----------------------------"
echo "./compile -j 1 em_real 2>&1 | tee -a compile-em_real-serial.log"
echo "=================================================================="
# Success looks like this:
# ==========================================================================
# build started:   Mon Jul 17 13:36:45 BST 2017
# build completed: Mon Jul 17 15:27:18 BST 2017
#  
# --->                  Executables successfully built                  <---
#  
# -rwxr-xr-x 1 mbexegc2 support 64777234 Jul 17 15:27 main/ndown.exe
# -rwxr-xr-x 1 mbexegc2 support 64577101 Jul 17 15:27 main/real.exe
# -rwxr-xr-x 1 mbexegc2 support 63537566 Jul 17 15:27 main/tc.exe
# -rwxr-xr-x 1 mbexegc2 support 76141671 Jul 17 15:25 main/wrf.exe
#  
# ==========================================================================
