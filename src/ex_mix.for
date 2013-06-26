c  Example program showing how to setup a mixture using the information
c  contained in a .mix file (located in the ...\Refprop\Mixtures directory).

      program EXAMPLE
      implicit double precision (a-h,o-z)
      implicit integer (i-k,m,n)
      parameter (ncmax=20)        !max number of components in mixture
      dimension x(ncmax),xliq(ncmax),xvap(ncmax)
      character hrf*3
      character*255 hf(ncmax),hfmix,hflnme,herr

c...If the fluid files are located in a directory that the code cannot
c.....find, make a call to SETPATH
      call SETPATH('/opt/refprop/')

      i=3;
      hflnme='nitrogen.fld|argon.fld|oxygen.fld'
      hfmix='hmx.bnc'
      hrf='DEF'
      herr='Ok'
      x(1)=.7812;     !Air composition
      x(2)=.0092;
      x(3)=.2096;

      !//...Call SETUP to initialize the program
      CALL SETUP0(i,hflnme,hfmix,hrf,ierr,herr);

      t=300.
      p=1.

c...Mixture properties use the exact same routines as those described
c...in EXAMPLE.FOR
      CALL TPRHO(t,p,x,j,k,d,ierr,herr)
      write (*,1000) t,p,d



      hflnme='R410A.mix'
      hfmix='hmx.bnc'
      hrf='DEF'

c...The SETMIX subroutine returns the number of fluids [ncc], fluid
c...names [hf()], and the composition of the mixture [x()].
      call SETMIX (hflnme,hfmix,hrf,ncc,hf,x,ierr,herr)
      if (ierr.ne.0) write (*,*) herr
      if (ierr.gt.0) stop

c...Calculate saturated liquid properties
      call SATT (t,x,1,p,dl,dv,xliq,xvap,ierr,herr)
      if (ierr.ne.0) write (*,*) herr
      write (*,1000) t,p,dl,dv,xliq(1),xvap(1)

c...Calculate saturated vapor properties
      call SATT (t,x,2,p,dl,dv,xliq,xvap,ierr,herr)
      if (ierr.ne.0) write (*,*) herr
      write (*,1000) t,p,dl,dv,xliq(1),xvap(1)

 1000 format (15f11.4)
      end
