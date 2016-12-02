# Use Intel 15.0.3 compiler
module load compilers/intel/c/15.0.3
module load compilers/intel/fortran/15.0.3

# Use Intel 15.0 openmpi
module load mpi/intel-15.0/openmpi/1.8.3-ib

# Where we'll do our build
export APPS=/opt/gridware/apps/intel-15.0
export LDIR=/opt/gridware/libs/intel-15.0
export TOOLS=/opt/gridware/tools/intel-15.0

# Downloaded installation files
export ZFILE=/scratch/mbexegc2/WRF_rpt/libs/zlib/archive/zlib-1.2.8.tar.gz
export HDFFILE=/scratch/mbexegc2/WRF_rpt/libs/hdf/5/archive/hdf5-1.8.16.tar.gz
export NC_CFILE=/scratch/mbexegc2/WRF_rpt/libs/netcdf/archive/netcdf-4.4.0.tar.gz
export NC_FFILE=/scratch/mbexegc2/WRF_rpt/libs/netcdf/archive/netcdf-fortran-4.4.2.tar.gz
export FLEXFILE=/scratch/mbexegc2/wrfchem-3.4.1/libs/flex/archive/flex-2.5.35.tar.gz
export YACCFILE=/scratch/mbexegc2/wrfchem-3.4.1/libs/byacc/from_source/archive/byacc-20160606.tar.gz

# CSF2 for Haswell *ONLY*
export FLAGS="-O3 -xCORE-AVX2"

# Dependency (zlib, hdf5, netcdf, netcdf-fortran) versions - *change* if doing a newer build
# These are the latest versions I've used but are different to the versions used in the 
# original CSF build in some cases. 
export ZVER=1.2.8
export HVER=1.8.16
export NVER=4.4.0c_4.4.2fortran
export NCVER=4.4.0
export NFVER=4.4.2
export FLEXVER=2.5.35
export YVER=20160606_wrf-chem-3.4.1

# Dependency directories (final installation directories that WRF will look in)
export ZROOT=$LDIR/zlib/$ZVER
export HROOT=$LDIR/hdf/5/$HVER
export NROOT=$LDIR/netcdf/$NVER
export FLEXROOT=$APPS/flex/$FLEXVER
export YROOT=$TOOLS/yacc/$YVER
