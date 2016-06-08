#!/Bin/Bash

#initial setup
cd ~
git clone https://github.com/SchedMD/slurm
cd slurm

#initial make lines
./configure
make
sudo make install

#config lines

