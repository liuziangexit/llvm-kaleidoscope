source clean.sh
mkdir tmp_build
cd tmp_build
cmake ..
echo "processor count: $(sysctl -n hw.logicalcpu)"
make -j$(sysctl -n hw.logicalcpu)
