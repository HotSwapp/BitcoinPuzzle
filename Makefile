#---------------------------------------------------------------------
# Makefile for VanitySearch
#
# Author : Jean-Luc PONS
# Modified for RTX 5090 support (Blackwell architecture)

SRC = Base58.cpp IntGroup.cpp main.cpp Random.cpp \
      Timer.cpp Int.cpp IntMod.cpp Point.cpp SECP256K1.cpp \
      Vanity.cpp GPU/GPUGenerate.cpp hash/ripemd160.cpp \
      hash/sha256.cpp hash/sha512.cpp hash/ripemd160_sse.cpp \
      hash/sha256_sse.cpp Bech32.cpp Wildcard.cpp

OBJDIR = obj

ifdef gpu

OBJET = $(addprefix $(OBJDIR)/, \
        Base58.o IntGroup.o main.o Random.o Timer.o Int.o \
        IntMod.o Point.o SECP256K1.o Vanity.o GPU/GPUGenerate.o \
        hash/ripemd160.o hash/sha256.o hash/sha512.o \
        hash/ripemd160_sse.o hash/sha256_sse.o \
        GPU/GPUEngine.o Bech32.o Wildcard.o)

else

OBJET = $(addprefix $(OBJDIR)/, \
        Base58.o IntGroup.o main.o Random.o Timer.o Int.o \
        IntMod.o Point.o SECP256K1.o Vanity.o GPU/GPUGenerate.o \
        hash/ripemd160.o hash/sha256.o hash/sha512.o \
        hash/ripemd160_sse.o hash/sha256_sse.o Bech32.o Wildcard.o)

endif

CXX        = g++
# CUDA path - update for your system (12.8+ required for RTX 5090 Blackwell)
CUDA       ?= /usr/local/cuda
CXXCUDA    ?= /usr/bin/g++
NVCC       = $(CUDA)/bin/nvcc

# Compute Capability (CCAP) options:
#   RTX 5090 (Blackwell): 10.0
#   RTX 4090 (Ada):       8.9
#   RTX 3090 (Ampere):    8.6
#   RTX 2080 (Turing):    7.5
#   GTX 1080 (Pascal):    6.1
# Default to 10.0 for RTX 5090 (Blackwell)
CCAP       ?= 10.0

# nvcc requires joint notation w/o dot, i.e. "5.2" -> "52"
ccap       = $(shell echo $(CCAP) | tr -d '.')

ifdef gpu
ifdef debug
CXXFLAGS   = -DWITHGPU -m64  -mssse3 -Wno-write-strings -g -I. -I$(CUDA)/include
else
CXXFLAGS   =  -DWITHGPU -m64 -mssse3 -Wno-write-strings -O2 -I. -I$(CUDA)/include
endif
LFLAGS     = -lpthread -L$(CUDA)/lib64 -lcudart
else
ifdef debug
CXXFLAGS   = -m64 -mssse3 -Wno-write-strings -g -I. -I$(CUDA)/include
else
CXXFLAGS   =  -m64 -mssse3 -Wno-write-strings -O2 -I. -I$(CUDA)/include
endif
LFLAGS     = -lpthread
endif


#--------------------------------------------------------------------

ifdef gpu
ifdef debug
$(OBJDIR)/GPU/GPUEngine.o: GPU/GPUEngine.cu
	$(NVCC) -G -maxrregcount=0 --ptxas-options=-v --compile --compiler-options -fPIC -ccbin $(CXXCUDA) -m64 -g -I$(CUDA)/include -gencode=arch=compute_$(ccap),code=sm_$(ccap) -o $(OBJDIR)/GPU/GPUEngine.o -c GPU/GPUEngine.cu
else
$(OBJDIR)/GPU/GPUEngine.o: GPU/GPUEngine.cu
	$(NVCC) -maxrregcount=0 --ptxas-options=-v --compile --compiler-options -fPIC -ccbin $(CXXCUDA) -m64 -O3 -I$(CUDA)/include -gencode=arch=compute_$(ccap),code=sm_$(ccap) -o $(OBJDIR)/GPU/GPUEngine.o -c GPU/GPUEngine.cu
endif
endif

# Multi-architecture build (for distributable binaries)
ifdef multi_gpu
$(OBJDIR)/GPU/GPUEngine.o: GPU/GPUEngine.cu
	$(NVCC) -maxrregcount=0 --ptxas-options=-v --compile --compiler-options -fPIC -ccbin $(CXXCUDA) -m64 -O3 -I$(CUDA)/include \
		-gencode=arch=compute_75,code=sm_75 \
		-gencode=arch=compute_86,code=sm_86 \
		-gencode=arch=compute_89,code=sm_89 \
		-gencode=arch=compute_100,code=sm_100 \
		-o $(OBJDIR)/GPU/GPUEngine.o -c GPU/GPUEngine.cu
endif

$(OBJDIR)/%.o : %.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<

all: VanitySearch

VanitySearch: $(OBJET)
	@echo Making VanitySearch...
	$(CXX) $(OBJET) $(LFLAGS) -o VanitySearch

$(OBJET): | $(OBJDIR) $(OBJDIR)/GPU $(OBJDIR)/hash

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(OBJDIR)/GPU: $(OBJDIR)
	cd $(OBJDIR) &&	mkdir -p GPU

$(OBJDIR)/hash: $(OBJDIR)
	cd $(OBJDIR) &&	mkdir -p hash

clean:
	@echo Cleaning...
	@rm -f obj/*.o
	@rm -f obj/GPU/*.o
	@rm -f obj/hash/*.o

# Help target
help:
	@echo "VanitySearch Build Options:"
	@echo ""
	@echo "  make all                    - Build CPU-only version"
	@echo "  make gpu=1 all              - Build with GPU support (default: RTX 5090)"
	@echo "  make gpu=1 CCAP=8.9 all     - Build for RTX 4090 (Ada)"
	@echo "  make gpu=1 CCAP=10.0 all    - Build for RTX 5090 (Blackwell)"
	@echo "  make gpu=1 multi_gpu=1 all  - Build multi-arch binary"
	@echo ""
	@echo "Environment variables:"
	@echo "  CUDA=/path/to/cuda          - CUDA toolkit path (12.8+ for Blackwell)"
	@echo "  CXXCUDA=/path/to/g++        - C++ compiler for CUDA"
	@echo "  CCAP=x.y                    - Compute capability (e.g., 8.9, 10.0)"
	@echo ""
	@echo "Common CCAP values:"
	@echo "  10.0  - RTX 5090 (Blackwell) [default]"
	@echo "  8.9   - RTX 4090/4080 (Ada)"
	@echo "  8.6   - RTX 3090/3080 (Ampere)"
	@echo "  7.5   - RTX 2080/2070 (Turing)"

