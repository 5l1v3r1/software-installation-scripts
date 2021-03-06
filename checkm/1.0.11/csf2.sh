# CheckM installation instructions are here: https://github.com/Ecogenomics/CheckM/wiki/Installation#how-to-install-checkm
# First create a directory to install into e.g. scratch/checkm
# This script is to be sourced from the directory above.

# Build dependencies in subdirectory
mkdir -p dependencies
cd dependencies
DEPDIR=$PWD

# hmmer
wget http://eddylab.org/software/hmmer/hmmer.tar.gz
tar -xzf hmmer.tar.gz
HVER=3.2.1
HDIR=$PWD/hmmer-$HVER-install
HSRC=hmmer-$HVER
mkdir $HDIR
cd $HSRC
./configure --prefix=$HDIR
make
make install

PATH=$HDIR/bin:$PATH

# Prodigal
cd $DEPDIR
git clone https://github.com/hyattpd/Prodigal.git
PVER=2.6.3
PRODDIR=$DEPDIR/prodigal-$PVER-install
mkdir $PRODDIR
cd Prodigal
make install INSTALLDIR=$PRODDIR

PATH=$PRODDIR:$PATH

# pplacer
cd $DEPDIR
wget https://github.com/matsen/pplacer/releases/download/v1.1.alpha17/pplacer-Linux-v1.1.alpha17.zip
unzip pplacer-Linux-v1.1.alpha17.zip
PPVER=1.1.alpha17
PPDIR=$DEPDIR/pplacer-Linux-v$PPVER

PATH=$PPDIR:$PATH

module load apps/binapps/anaconda/2.5.0
module load tools/env/proxy2
module load libs/gcc/xz-lzma/5.2.2

pip install --user checkm-genome
# Add checkm to PATH - above pip install command didn't work, but on desktop location was ~/anaconda3/envs/python2.7/bin/checkm
