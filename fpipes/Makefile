default:
	gfortran -g -c mfpipes.f90 -o mfpipes.o
	gfortran -g -c testfpipes.f90 -o testfpipes.o
	gfortran -g mfpipes.o testfpipes.o -o testfpipes.elf

roda: default
	./testfpipes.elf
