# Installation
# ------------
# The instructions here are incomplete: https://openfoam.org/download/4-1-source/
# Instead, follow instructions here: https://openfoamwiki.net/index.php/Installation/Linux/OpenFOAM-4.1/Ubuntu
# 
# Compilation requires gcc > 4.5.
# Don't compile ParaView, so don't need cmake, or QT.
# Do need OpenMPI.
 
# Load modules
module load compilers/gcc/6.3.0 # (most recent on CSF)
module load mpi/gcc/openmpi/1.8
module load libs/gcc/boost/1.55.0
module load libs/gcc/cgal/4.9
module load tools/env/proxy

# Create directory and download source code
mkdir /opt/gridware/apps/gcc/openfoam/4.1
cd /opt/gridware/apps/gcc/openfoam/4.1
wget -O - http://dl.openfoam.org/source/4-1 | tar xvz
wget -O - http://dl.openfoam.org/third-party/4-1 | tar xvz
mv OpenFOAM-4.x-version-4.1 OpenFOAM-4.1
mv ThirdParty-4.x-version-4.1 ThirdParty-4.1
cd /opt/gridware/apps/gcc/openfoam/4.1

# Manually edit installation directory in bashrc file:
vim /opt/gridware/apps/gcc/openfoam/4.1/OpenFOAM-4.1/etc/bashrc
	#[ $BASH_SOURCE ] && \
	#export FOAM_INST_DIR=$(cd ${BASH_SOURCE%/*/*/*} && pwd -P) || \
	#export FOAM_INST_DIR=$HOME/$WM_PROJECT
	export FOAM_INST_DIR=/opt/gridware/apps/gcc/openfoam/$WM_PROJECT_VERSION

# We have built CGAL separately, so no need to edit ThirdParty-4.1/makeCGAL

vim /opt/gridware/apps/gcc/openfoam/4.1/OpenFOAM-4.1/etc/config.sh/CGAL
	# Near the top of the file, make the following changes:
	#   export BOOST_ARCH_PATH=$common_path/$boost_version
	    export BOOST_ARCH_PATH=$BOOST_ROOT
	#   export CGAL_ARCH_PATH=$common_path/$cgal_version
	    export CGAL_ARCH_PATH=$CGAL_DIR

# Set environment variables
. OpenFOAM-4.1/etc/bashrc

# Install third party software (just scotch)
cd /opt/gridware/apps/gcc/openfoam/4.1/ThirdParty-4.1
./Allwmake 2>&1 | tee allwmake.log

# Install OpenFOAM
cd ../OpenFOAM-4.1
./Allwmake 2>&1 | tee allwmake.log

# Run tutorial tests
mkdir -p $FOAM_RUN
cp -r $FOAM_TUTORIALS $FOAM_RUN
cd $FOAM_RUN/tutorials
./Alltest 2>&1 | tee alltest.log

# Usage
#------
