! Main program for testing mfpipes module
! gnuplot 4.6 patchlevel 4 was used on Ubuntu 14.04 for this test
! it can be obtained using the following comands
! sudo apt-get install gnuplot gnuplot-x11
program testfpipes
  use mfpipes 
  implicit none
  integer, parameter :: BUFLEN=5000
  character(len=BUFLEN) :: lin, lin0
  character (len=3) :: mode
  integer (kind=c_int) :: clen
  integer :: eos, i
  type(streampointer) :: fp
  character(len=99) :: paused
  integer :: ios
  integer :: col1, col2

  
  mode='w' !'r'
  
!!pipe for GENERIC command line execution:
!  call get_command_ARGUMENT(0,lin0)
!!print*, "o nome do executável foi:"
!!print*, trim(lin0)
!!print*, " e tem "
!!print*, len(trim(lin0))
!!print*, " caracteres"
!  call get_command(lin)
!!print*, "e se o comando todo foi:"
!!print*, trim(lin)
!!print*, "então os argumentos foram:"
!!print*, trim(lin(len(trim(lin0))+1:len(trim(lin))))
!!print*, "my job here is done."
!  
!  lin = trim(lin(len(trim(lin0))+2:len(trim(lin))))
!!print*, lin

!  if (lin == '' .or. lin == '-h' .or. lin == '--help') then
!    write(*,'(a)') 'Usage: run-process <command>'
!    stop
!  end if
!  fp%handle = popen(trim(lin) // C_NULL_CHAR, trim(mode) // C_NULL_CHAR)
!!:pipe for GENERIC command line execution

!!handle for a FILE:
!  fp%handle = fopen( "data.dat"//C_NULL_CHAR, trim(mode) // C_NULL_CHAR)

!!pipe for GNUPLOT:
  fp%handle = popen( c_char_"gnuplot -persistent" //C_NULL_CHAR, trim(mode) // C_NULL_CHAR)

!VERIFICATION:
  if (.not.c_associated(fp%handle)) then
    write(*,*) 'ERROR: Could not open pipe!'
    stop
  else
print*,;
print*, 'Opened pipe successfully'
  end if
  
!print*, "calling fprintf"
!print*, c_associated(fprintf(fp%handle, c_char_"libreoffice"//char(10)//C_NULL_CHAR))
!print*, c_associated(fprintf(fp%handle, c_char_"libreoffice"//C_NULL_CHAR))
!stop

   ios = fprintf(fp%handle,c_char_"set xlabel 'T[K]'"//char(10)//C_NULL_CHAR)
   ios = fprintf(fp%handle,c_char_"set ylabel 'P[Pa]'"//char(10)//C_NULL_CHAR)
   ios = fprintf(fp%handle,"set title 'argumento identificando composição global'"//char(10)//C_NULL_CHAR)
   ios = fprintf(fp%handle,"set key right bottom"//char(10)//C_NULL_CHAR)
   ios = fprintf(fp%handle,"set logscale y 10"//char(10)//C_NULL_CHAR)
   ios = fprintf(fp%handle,"set format y '10^{%%L}'"//char(10)//C_NULL_CHAR)
   ios = fprintf(fp%handle,"set terminal wxt enhanced"//char(10)//C_NULL_CHAR)
print*,;print*, "Shall we plot the sample plot?"
read(*,*) paused
print*,;print*, "I'm plotting anyway."
col1=5
col2=6
   ios = fprintf(fp%handle,"plot 'thisplot.dat' every ::1 using ($"//trim(int2str(col1))//"):($"//trim(int2str(col2))// &
  ") title 'argumento identificando fase incipiente' with lines lt 2 lw 2 lc rgb 'red'"//char(10)//C_NULL_CHAR)
   ios = fprintf(fp%handle,"q"//char(10)//C_NULL_CHAR)
   ios = pclose(fp%handle)
   
   contains
   
  !=================================================================================================
  
  elemental function int2str( i ) result( str )
    integer, intent(in) :: i
    character(256) :: str
    write(str,*) i
    str = adjustl(str)
  end function int2str
  
  !=================================================================================================
  
end program testfpipes
