!source: http://www.44342.com/fortran-f849-t9703-p1.htm
module mfpipes
  
  use, intrinsic :: ISO_C_BINDING
  
  !=================================================================================================
  
  type, public :: streampointer
    type (c_ptr) :: handle = c_null_ptr
  end type streampointer
  
  !=================================================================================================
  
! popen  
  interface
    function popen(path, mode) bind(C, name='popen')
      use, intrinsic :: ISO_C_BINDING
      type (c_ptr) :: popen
      character(kind=c_char), dimension(*) :: path, mode
    end function
  end interface
  
  !=================================================================================================
  
! fopen  
  interface
    function fopen(path, mode) bind(C, name='fopen')
      use, intrinsic :: ISO_C_BINDING
      type (c_ptr) :: fopen
      character(kind=c_char), dimension(*) :: path, mode
    end function
  end interface
  
  !=================================================================================================
  
! fgets  
  interface
    function fgets(buf, siz, handle) bind(C, name='fgets')
      use, intrinsic :: ISO_C_BINDING
      type (c_ptr) :: fgets
      character(kind=c_char), dimension(*) :: buf
      integer(kind=c_int), value :: siz
      type (c_ptr), value :: handle
    end function
  end interface
  
  !=================================================================================================
  
! pclose  
  interface
    function pclose(handle) bind(C, name='pclose')
    use, intrinsic :: ISO_C_BINDING
    integer(c_int) :: pclose
    type (c_ptr), value :: handle
    end function
  end interface
  
  !=================================================================================================
  
! fprintf  
  interface
    function fprintf(fileptr, string) bind(C, name='fprintf')
      use, intrinsic :: ISO_C_BINDING
      integer(c_int) :: fprintf ! Upon successful completion, these functions return the number of bytes transmitted excluding the terminating null in the case of sprintf() or snprintf() or a negative value if an output error was encountered. 
      type (c_ptr), value :: fileptr
      character(kind=c_char), dimension(*) :: string
    end function
  end interface
  
  !=================================================================================================
  
end module mfpipes
