# Set variables for convenient directory naming
export OF_ROOT=/opt/gridware/apps/gcc/openfoam/5.0
cd $OF_ROOT

# Download source files
wget -O - http://dl.openfoam.org/source/5-0 | tar xz
wget -O - http://dl.openfoam.org/third-party/5-0 | tar xz

# Rename directories
mv OpenFOAM-5.x-version-5.0 OpenFOAM-5.0
mv ThirdParty-5.x-version-5.0 ThirdParty-5.0

# Software for compilation
# gcc 4.5 or above
module load compilers/gcc/6.3.0
# flex (available by default on CSF)
# OpenMPI
module load mpi/gcc-6/openmpi/1.8

# Set the environment for OpenFOAM
# For this version, it correctly sets FOAM_INST_DIR and WM_PROJECT_DIR
. OpenFOAM-5.0/etc/bashrc

# Install third party software
# We do this separately for CGAL, don't build Paraview, so it's only
# Scotch which is built.
# Load CGAL module
module load libs/gcc/cgal/4.9
# Boost is required by CGAL
module load libs/gcc/boost/1.57.0
# For OpenFOAM 4.1, editing etc/config.sh/CGAL worked, however I couldn't figure it out.
# So instead, just set two environment variables from the shell:
export BOOST_ARCH_PATH=$BOOST_ROOT
export CGAL_ARCH_PATH=$CGAL_DIR

# Install third party software (just scotch)
cd $OF_ROOT/ThirdParty-5.0
./Allwmake 2>&1 | tee allwmake.log

# Install OpenFOAM
cd $OF_ROOT/OpenFOAM-5.0
./Allwmake 2>&1 | tee allwmake.log

# Run tutorial tests
mkdir -p $FOAM_RUN
cp -r $FOAM_TUTORIALS $FOAM_RUN
cd $FOAM_RUN/tutorials
./Alltest 2>&1 | tee alltest.log
