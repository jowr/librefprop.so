      subroutine RPVersion (v)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_RPVersion"::RPVersion
cDEC$ ATTRIBUTES STDCALL, REFERENCE::RPVersion
      !dll_export RPVersion
      character v*255
      v='8.01c'
      end
c ======================================================================
c     subroutine WRTREFdll(fxname)
c     implicit double precision (a-h,o-z)
c     implicit integer (i-n)
c     character*255 fxname
c     !dll_export WRTREFdll
c     call WRTREF (fxname,-1,1,0,0,0)
c     end
c
c     subroutine MINIMIZEdll(fxname,idfile,mn,i)
c     implicit double precision (a-h,o-z)
c     implicit integer (i-n)
c     character*255 fxname,idfile
c     double precision mn(200)
c     !dll_export MINIMIZEdll
c     call minimize(fxname,idfile,mn,i)
c     end
c
c     subroutine FOFXdll(mn,i,fofxx,ierr,herr)
c     implicit double precision (a-h,o-z)
c     implicit integer (i-n)
c     character*255 herr
c     double precision mn(200)
c     !dll_export FOFXdll
c     call fofx(mn,i,fofxx,ierr,herr)
c     end
c ======================================================================

c ======================================================================
c  begin file pass_ftn.for
c
c  This file defines the DLL-callable routines which would be used by
c  Visual Basic, Excel, and other applications to access the main
c  Fortran code.  It is not needed when compiling Fortran applications.
c  It is only used when compiling the DLL and contains commands specific
c  to the Lahey/Fujitsu Fortran 95 Compiler.  When using other compilers,
c  the lines with '!dll_export' should be commented out.
c
c  The calling sequence is identical (except for the SETUPdll routine) to
c  the main Fortran routines, with the letters 'dll' appended to the routine
c  name.  See the Excel sample file or the Visual Basic 'SAMPLE.BAS'
c  file for usage information.
c
c ======================================================================
c
      subroutine SETUPdll (i,hfld,hfm,hrf,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-k,m,n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETUPdll"::SETUPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETUPdll
      !dll_export SETUPdll
      character hfld*10000,hfm*255,hrf*3,herr*255
      call SETUP0 (i,hfld,hfm,hrf,ierr,herr)
      end
c ======================================================================
      subroutine SETREFdll (hrf,ixflag,x0,h0,s0,t0,p0,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
      character*3 hrf
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETREFdll"::SETREFdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETREFdll
      !dll_export SETREFdll
      dimension x0(ncmax)
      call SETREF (hrf,ixflag,x0,h0,s0,t0,p0,ierr,herr)
      end
c ======================================================================
      subroutine SETMIXdll (hmxnme,hfmix,hrf,ncc,hfile,x,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 hmxnme,hfmix,hfiles(ncmax),herr
      character hfile*10000,hrf*3
      dimension x(ncmax)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETMIXdll"::SETMIXdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETMIXdll
      !dll_export SETMIXdll
      call SETMIX (hmxnme,hfmix,hrf,ncc,hfiles,x,ierr,herr)
      hfile=hfiles(1)
      j=index(hfile,' ')
      hfile=hfile(1:j-1)//'|'
      do i=2,ncc
        j=index(hfile,' ')
        hfile=hfile(1:j-1)//hfiles(i)
        j=index(hfile,' ')
        hfile=hfile(1:j-1)//'|'
      enddo
      end
c ======================================================================
      subroutine SETMODdll (nc,htype,hmix,hcomp2,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
      character*60 hcomp2
      character*3 htype,hmix,hcomp(1:ncmax)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETMODdll"::SETMODdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETMODdll
      !dll_export SETMODdll
      do i=1,ncmax
        hcomp(i)=hcomp2(i*3-2:i*3)
      enddo
      call SETMOD (nc,htype,hmix,hcomp,ierr,herr)
      end
c ======================================================================
      subroutine PUREFLDdll (icomp)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PUREFLDdll"::PUREFLDdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PUREFLDdll
      !dll_export PUREFLDdll
      call PUREFLD (icomp)
      end
c ======================================================================
      subroutine SETNCdll (ncomp)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETNCdll"::SETNCdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETNCdll
      !dll_export SETNCdll
      call SETNC (ncomp)
      end
c ======================================================================
      subroutine SETPATHdll (hpth)
      character hpth*255
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETPATHdll"::SETPATHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETPATHdll
      !dll_export SETPATHdll
      call SETPATH (hpth)
      end
c ======================================================================
      subroutine UNSETAGAdll
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_UNSETAGAdll"::UNSETAGAdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::UNSETAGAdll
      !dll_export UNSETAGAdll
      call UNSETAGA
      end
c ======================================================================
      subroutine CRITPdll (x,tcrit,pcrit,Dcrit,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CRITPdll"::CRITPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CRITPdll
      !dll_export CRITPdll
      dimension x(ncmax)
      call CRITP (x,tcrit,pcrit,Dcrit,ierr,herr)
      end
c ======================================================================
      subroutine THERMdll (t,rho,x,p,e,h,s,cv,cp,w,hjt)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_THERMdll"::THERMdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::THERMdll
      !dll_export THERMdll
      dimension x(ncmax)
      call THERM (t,rho,x,p,e,h,s,cv,cp,w,hjt)
      end
c ======================================================================
      subroutine THERM0dll (t,rho,x,p,e,h,s,cv,cp,w,a,g)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_THERM0dll"::THERM0dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::THERM0dll
      !dll_export THERM0dll
      dimension x(ncmax)
      call THERM0 (t,rho,x,p,e,h,s,cv,cp,w,a,g)
      end
c ======================================================================
      subroutine THERM2dll (t,rho,x,p,e,h,s,cv,cp,w,Z,hjt,A,G,xkappa,
     &                   beta,dPdD,d2PdD2,dPdT,dDdT,dDdP,
     &                   d2PT2,d2PdTD,spare3,spare4)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_THERM2dll"::THERM2dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::THERM2dll
      !dll_export THERM2dll
      dimension x(ncmax)
      call THERM2 (t,rho,x,p,e,h,s,cv,cp,w,Z,hjt,A,G,xkappa,beta,
     &                   dPdD,d2PdD2,dPdT,dDdT,dDdP,
     &                   d2PT2,d2PdTD,spare3,spare4)
      end
c ======================================================================
      subroutine THERM3dll (t,rho,x,
     &           xkappa,beta,xisenk,xkt,betas,bs,xkkt,thrott,pi,spht)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_THERM3dll"::THERM3dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::THERM3dll
      !dll_export THERM3dll
      dimension x(ncmax)
      call THERM3 (t,rho,x,
     &           xkappa,beta,xisenk,xkt,betas,bs,xkkt,thrott,pi,spht)
      end
c ======================================================================
      subroutine RESIDUALdll (t,rho,x,pr,er,hr,sr,cvr,cpr,Ar,Gr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_RESIDUALdll"::RESIDUALdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::RESIDUALdll
      !dll_export RESIDUALdll
      dimension x(ncmax)
      call RESIDUAL (t,rho,x,pr,er,hr,sr,cvr,cpr,Ar,Gr)
      end
c ======================================================================
      subroutine ENTROdll (t,rho,x,s)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_ENTROdll"::ENTROdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::ENTROdll
      !dll_export ENTROdll
      dimension x(ncmax)
      call ENTRO (t,rho,x,s)
      end
c ======================================================================
      subroutine ENTHALdll (t,rho,x,h)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_ENTHALdll"::ENTHALdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::ENTHALdll
      !dll_export ENTHALdll
      dimension x(ncmax)
      call ENTHAL (t,rho,x,h)
      end
c ======================================================================
      subroutine CVCPdll (t,rho,x,cv,cp)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CVCPdll"::CVCPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CVCPdll
      !dll_export CVCPdll
      dimension x(ncmax)
      call CVCP (t,rho,x,cv,cp)
      end
c ======================================================================
      subroutine CVCPKdll (icomp,t,rho,cv,cp)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CVCPKdll"::CVCPKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CVCPKdll
      !dll_export CVCPKdll
      call CVCPK (icomp,t,rho,cv,cp)
      end
c ======================================================================
      subroutine GIBBSdll (t,rho,x,Ar,Gr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_GIBBSdll"::GIBBSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::GIBBSdll
      !dll_export GIBBSdll
      dimension x(ncmax)
      call GIBBS (t,rho,x,Ar,Gr)
      end
c ======================================================================
      subroutine AGdll (t,rho,x,a,g)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_AGdll"::AGdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::AGdll
      !dll_export AGdll
      dimension x(ncmax)
      call AG (t,rho,x,a,g)
      end
c ======================================================================
      subroutine PRESSdll (t,rho,x,p)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PRESSdll"::PRESSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PRESSdll
      !dll_export PRESSdll
      dimension x(ncmax)
      call PRESS (t,rho,x,p)
      end
c ======================================================================
      subroutine DPDDdll (t,rho,x,dpdrho)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DPDDdll"::DPDDdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DPDDdll
      !dll_export DPDDdll
      dimension x(ncmax)
      call DPDD (t,rho,x,dpdrho)
      end
c ======================================================================
      subroutine DPDDKdll (icomp,t,rho,dpdrho)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DPDDKdll"::DPDDKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DPDDKdll
      !dll_export DPDDKdll
      call DPDDK (icomp,t,rho,dpdrho)
      end
c ======================================================================
      subroutine DPDD2dll (t,rho,x,d2PdD2)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DPDD2dll"::DPDD2dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DPDD2dll
      !dll_export DPDD2dll
      dimension x(ncmax)
      call DPDD2 (t,rho,x,d2PdD2)
      end
c ======================================================================
      subroutine DPDTdll (t,rho,x,dpt)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DPDTdll"::DPDTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DPDTdll
      !dll_export DPDTdll
      dimension x(ncmax)
      call DPDT (t,rho,x,dpt)
      end
c ======================================================================
      subroutine DPDTKdll (icomp,t,rho,dpt)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DPDTKdll"::DPDTKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DPDTKdll
      !dll_export DPDTKdll
      call DPDTK (icomp,t,rho,dpt)
      end
c ======================================================================
      subroutine DDDPdll (t,rho,x,drhodp)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DDDPdll"::DDDPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DDDPdll
      !dll_export DDDPdll
      dimension x(ncmax)
      call DDDP (t,rho,x,drhodp)
      end
c ======================================================================
      subroutine DDDTdll (t,rho,x,drhodt)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DDDTdll"::DDDTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DDDTdll
      !dll_export DDDTdll
      dimension x(ncmax)
      call DDDT (t,rho,x,drhodt)
      end
c ======================================================================
      subroutine DHD1dll (t,rho,x,dhdt_d,dhdt_p,dhdd_t,dhdd_p,dhdp_t,
     &                    dhdp_d)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DHD1dll"::DHD1dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DHD1dll
      !dll_export DHD1dll
      dimension x(ncmax)
      call DHD1 (t,rho,x,dhdt_d,dhdt_p,dhdd_t,dhdd_p,dhdp_t,dhdp_d)
      end
c ======================================================================
      subroutine FGCTYdll (t,rho,x,f)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_FGCTYdll"::FGCTYdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::FGCTYdll
      !dll_export FGCTYdll
      dimension x(ncmax),f(ncmax)
      call FGCTY (t,rho,x,f)
      end
c ======================================================================
      subroutine FGCTY2dll (t,rho,x,f,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_FGCTY2dll"::FGCTY2dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::FGCTY2dll
      !dll_export FGCTY2dll
      dimension x(ncmax),f(ncmax)
      call FGCTY2 (t,rho,x,f,ierr,herr)
      end
c ======================================================================
      subroutine FUGCOFdll (t,rho,x,f,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_FUGCOFdll"::FUGCOFdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::FUGCOFdll
      !dll_export FUGCOFdll
      dimension x(ncmax),f(ncmax)
      call FUGCOF (t,rho,x,f,ierr,herr)
      end
c ======================================================================
      subroutine CHEMPOTdll (t,rho,x,u,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CHEMPOTdll"::CHEMPOTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CHEMPOTdll
      !dll_export CHEMPOTdll
      dimension x(ncmax),u(ncmax)
      call CHEMPOT (t,rho,x,u,ierr,herr)
      end
c ======================================================================
      subroutine ACTVYdll (t,rho,x,actv,gamma,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_ACTVYdll"::ACTVYdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::ACTVYdll
      !dll_export ACTVYdll
      dimension x(ncmax),actv(ncmax),gamma(ncmax)
      call ACTVY (t,rho,x,actv,gamma,ierr,herr)
      end
c ======================================================================
      subroutine VIRBdll (t,x,b)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_VIRBdll"::VIRBdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::VIRBdll
      !dll_export VIRBdll
      dimension x(ncmax)
      call VIRB (t,x,b)
      end
c ======================================================================
      subroutine B12dll (t,x,b)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_B12dll"::B12dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::B12dll
      !dll_export B12dll
      dimension x(ncmax)
      call B12 (t,x,b)
      end
c ======================================================================
      subroutine DBDTdll (t,x,b)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DBDTdll"::DBDTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DBDTdll
      !dll_export DBDTdll
      dimension x(ncmax)
      call DBDT (t,x,b)
      end
c ======================================================================
      subroutine VIRCdll (t,x,c)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_VIRCdll"::VIRCdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::VIRCdll
      !dll_export VIRCdll
      dimension x(ncmax)
      call VIRC (t,x,c)
      end
c ======================================================================
      subroutine VIRBAdll (t,x,b)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_VIRBAdll"::VIRBAdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::VIRBAdll
      !dll_export VIRBAdll
      dimension x(ncmax)
      call VIRBA (t,x,b)
      end
c ======================================================================
      subroutine VIRCAdll (t,x,c)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_VIRCAdll"::VIRCAdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::VIRCAdll
      !dll_export VIRCAdll
      dimension x(ncmax)
      call VIRCA (t,x,c)
      end
c ======================================================================
      subroutine HEATdll (t,rho,x,hg,hn,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_HEATdll"::HEATdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::HEATdll
      !dll_export HEATdll
      dimension x(ncmax)
      CALL HEAT (t,rho,x,hg,hn,ierr,herr)
      end
c ======================================================================
      subroutine SATTPdll (t,p,x,kph,iGuess,d,rhol,rhov,xliq,xvap,q,
     &                     ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATTPdll"::SATTPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATTPdll
      !dll_export SATTPdll
      dimension x(ncmax),xliq(ncmax),xvap(ncmax)
      call SATTP (t,p,x,kph,iGuess,d,rhol,rhov,xliq,xvap,q,ierr,herr)
      end
c ======================================================================
      subroutine SATTdll (t,x,kph,p,rhol,rhov,xliq,xvap,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATTdll"::SATTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATTdll
      !dll_export SATTdll
      dimension x(ncmax),xliq(ncmax),xvap(ncmax)
      call SATT (t,x,kph,p,rhol,rhov,xliq,xvap,ierr,herr)
      end
c ======================================================================
      subroutine SATPdll (p,x,kph,t,rhol,rhov,xliq,xvap,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATPdll"::SATPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATPdll
      !dll_export SATPdll
      dimension x(ncmax),xliq(ncmax),xvap(ncmax)
      call SATP (p,x,kph,t,rhol,rhov,xliq,xvap,ierr,herr)
      end
c ======================================================================
      subroutine SATDdll (rho,x,kph,kr,t,p,rhol,rhov,xliq,xvap,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATDdll"::SATDdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATDdll
      !dll_export SATDdll
      dimension x(ncmax),xliq(ncmax),xvap(ncmax)
      call SATD (rho,x,kph,kr,t,p,rhol,rhov,xliq,xvap,i,herr)
      end
c ======================================================================
      subroutine SATHdll (h,x,kph,nroot,k1,t1,p1,d1,k2,t2,p2,d2,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATHdll"::SATHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATHdll
      !dll_export SATHdll
      dimension x(ncmax)
      call SATH (h,x,kph,nroot,k1,t1,p1,d1,k2,t2,p2,d2,i,herr)
      end
c ======================================================================
      subroutine SATEdll (e,x,kph,nroot,k1,t1,p1,d1,k2,t2,p2,d2,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATEdll"::SATEdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATEdll
      !dll_export SATEdll
      dimension x(ncmax)
      call SATE (e,x,kph,nroot,k1,t1,p1,d1,k2,t2,p2,d2,i,herr)
      end
c ======================================================================
      subroutine SATSdll (s,x,kph,nroot,k1,t1,p1,d1,k2,t2,p2,d2,
     &                 k3,t3,p3,d3,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATSdll"::SATSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATSdll
      !dll_export SATSdll
      dimension x(ncmax)
      call SATS (s,x,kph,nroot,k1,t1,p1,d1,k2,t2,p2,d2,
     &                 k3,t3,p3,d3,ierr,herr)
      end
c ======================================================================
      subroutine SATTESTdll (t,x,kph,p,x2,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATTESTdll"::SATTESTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATTESTdll
      !dll_export SATTESTdll
      dimension x(ncmax),x2(ncmax)
      call SATTEST (t,x,kph,p,x2,ierr,herr)
      end
c ======================================================================
      subroutine SATPESTdll (p,x,kph,t,x2,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SATPESTdll"::SATPESTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SATPESTdll
      !dll_export SATPESTdll
      dimension x(ncmax),x2(ncmax)
      call SATPEST (p,x,kph,t,x2,ierr,herr)
      end
c ======================================================================
      subroutine CSATKdll (icomp,t,kph,p,rho,csat,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CSATKdll"::CSATKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CSATKdll
      !dll_export CSATKdll
      call CSATK (icomp,t,kph,p,rho,csat,ierr,herr)
      end
c ======================================================================
      subroutine DPTSATKdll (icomp,t,kph,p,rho,csat,dpt,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DPTSATKdll"::DPTSATKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DPTSATKdll
      !dll_export DPTSATKdll
      call DPTSATK (icomp,t,kph,p,rho,csat,dpt,ierr,herr)
      end
c ======================================================================
      subroutine CV2PKdll (icomp,t,rho,cv2p,csat,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CV2PKdll"::CV2PKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CV2PKdll
      !dll_export CV2PKdll
      call CV2PK (icomp,t,rho,cv2p,csat,ierr,herr)
      end
c ======================================================================
      subroutine PSATKdll (icomp,t,p,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PSATKdll"::PSATKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PSATKdll
      !dll_export PSATKdll
      call PSATK (icomp,t,p,ierr,herr)
      end
c ======================================================================
      subroutine DLSATKdll (icomp,t,d,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DLSATKdll"::DLSATKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DLSATKdll
      !dll_export DLSATKdll
      call DLSATK (icomp,t,d,ierr,herr)
      end
c ======================================================================
      subroutine DVSATKdll (icomp,t,d,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DVSATKdll"::DVSATKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DVSATKdll
      !dll_export DVSATKdll
      call DVSATK (icomp,t,d,ierr,herr)
      end
c ======================================================================
      subroutine SPNDLdll (t,x,rhol,rhov,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SPNDLdll"::SPNDLdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SPNDLdll
      !dll_export SPNDLdll
      dimension x(ncmax)
      call SPNDL (t,x,rhol,rhov,ierr,herr)
      end
c ======================================================================
      subroutine TPRHOdll (t,p,x,j,i,rho,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TPRHOdll"::TPRHOdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TPRHOdll
      !dll_export TPRHOdll
      dimension x(ncmax)
      call TPRHO (t,p,x,j,i,rho,ierr,herr)
      end
c ======================================================================
      subroutine TPRHOPRdll (t,p,x,rho1,rho2)
      implicit double precision (a-h,o-z)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TPRHOPRdll"::TPRHOPRdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TPRHOPRdll
      !dll_export TPRHOPRdll
      dimension x(ncmax)
      call TPRHOPR (t,p,x,rho1,rho2)
      end
c ======================================================================
      subroutine TPFLSHdll (t,p,z,D,Dl,Dv,x,y,q,e,h,s,cv,cp,w,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TPFLSHdll"::TPFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TPFLSHdll
      !dll_export TPFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      if (t.gt.0.d0)
     &    call TPFLSH (t,p,z,D,Dl,Dv,x,y,q,e,h,s,cv,cp,w,ierr,herr)
      end
c ======================================================================
      subroutine TDFLSHdll (t,D,x,p,Dl,Dv,xl,xv,q,e,h,s,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TDFLSHdll"::TDFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TDFLSHdll
      !dll_export TDFLSHdll
      dimension x(ncmax),xl(ncmax),xv(ncmax)
      call TDFLSH (t,D,x,p,Dl,Dv,xl,xv,q,e,h,s,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine PDFLSHdll (p,D,z,t,Dl,Dv,x,y,q,e,h,s,cv,cp,w,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PDFLSHdll"::PDFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PDFLSHdll
      !dll_export PDFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call PDFLSH (p,D,z,t,Dl,Dv,x,y,q,e,h,s,cv,cp,w,ierr,herr)
      end
c ======================================================================
      subroutine PHFLSHdll (p,h,z,t,D,Dl,Dv,x,y,q,e,s,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PHFLSHdll"::PHFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PHFLSHdll
      !dll_export PHFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call PHFLSH (p,h,z,t,D,Dl,Dv,x,y,q,e,s,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine PSFLSHdll (p,s,z,t,D,Dl,Dv,x,y,q,e,h,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PSFLSHdll"::PSFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PSFLSHdll
      !dll_export PSFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call PSFLSH (p,s,z,t,D,Dl,Dv,x,y,q,e,h,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine PEFLSHdll (p,e,z,t,D,Dl,Dv,x,y,q,h,s,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PEFLSHdll"::PEFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PEFLSHdll
      !dll_export PEFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call PEFLSH (p,e,z,t,D,Dl,Dv,x,y,q,h,s,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine THFLSHdll (t,h,z,kr,p,D,Dl,Dv,x,y,q,e,s,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_THFLSHdll"::THFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::THFLSHdll
      !dll_export THFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call THFLSH (t,h,z,kr,p,D,Dl,Dv,x,y,q,e,s,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine TSFLSHdll (t,s,z,kr,p,D,Dl,Dv,x,y,q,e,h,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TSFLSHdll"::TSFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TSFLSHdll
      !dll_export TSFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call TSFLSH (t,s,z,kr,p,D,Dl,Dv,x,y,q,e,h,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine TEFLSHdll (t,e,z,kr,p,D,Dl,Dv,x,y,q,h,s,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TEFLSHdll"::TEFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TEFLSHdll
      !dll_export TEFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call TEFLSH (t,e,z,kr,p,D,Dl,Dv,x,y,q,h,s,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine DHFLSHdll (D,h,z,t,p,Dl,Dv,x,y,q,e,s,cv,cp,w,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DHFLSHdll"::DHFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DHFLSHdll
      !dll_export DHFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call DHFLSH (D,h,z,t,p,Dl,Dv,x,y,q,e,s,cv,cp,w,ierr,herr)
      end
c ======================================================================
      subroutine DSFLSHdll (D,s,z,t,p,Dl,Dv,x,y,q,e,h,cv,cp,w,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DSFLSHdll"::DSFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DSFLSHdll
      !dll_export DSFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call DSFLSH (D,s,z,t,p,Dl,Dv,x,y,q,e,h,cv,cp,w,ierr,herr)
      end
c ======================================================================
      subroutine DEFLSHdll (D,e,z,t,p,Dl,Dv,x,y,q,h,s,cv,cp,w,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DEFLSHdll"::DEFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DEFLSHdll
      !dll_export DEFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call DEFLSH (D,e,z,t,p,Dl,Dv,x,y,q,h,s,cv,cp,w,ierr,herr)
      end
c ======================================================================
      subroutine HSFLSHdll (h,s,z,t,p,D,Dl,Dv,x,y,q,e,cv,cp,w,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_HSFLSHdll"::HSFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::HSFLSHdll
      !dll_export HSFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call HSFLSH (h,s,z,t,p,D,Dl,Dv,x,y,q,e,cv,cp,w,ierr,herr)
      end
c ======================================================================
      subroutine ESFLSHdll (e,s,z,t,p,D,Dl,Dv,x,y,q,h,cv,cp,w,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_ESFLSHdll"::ESFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::ESFLSHdll
      !dll_export ESFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call ESFLSH (e,s,z,t,p,D,Dl,Dv,x,y,q,h,cv,cp,w,ierr,herr)
      end
c ======================================================================
      subroutine ABFL1dll (a,b,x,kph,ab,dmin,dmax,t,p,D,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*2 ab
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_ABFL1dll"::ABFL1dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::ABFL1dll
      !dll_export ABFL1dll
      dimension x(ncmax)
      call ABFL1 (a,b,x,kph,ab,dmin,dmax,t,p,D,ierr,herr)
      end
c ======================================================================
      subroutine DBFL1dll (d,b,x,ab,t,p,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*2 ab
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DBFL1dll"::DBFL1dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DBFL1dll
      !dll_export DBFL1dll
      dimension x(ncmax)
      call DBFL1 (d,b,x,ab,t,p,ierr,herr)
      end
c ======================================================================
      subroutine ABFL2dll (a,b,z,kq,ksat,ab,
     &                     tbub,tdew,pbub,pdew,Dlbub,Dvdew,ybub,xdew,
     &                     t,p,Dl,Dv,x,y,q,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*2 ab
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_ABFL2dll"::ABFL2dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::ABFL2dll
      !dll_export ABFL2dll
      dimension z(ncmax),ybub(ncmax),xdew(ncmax),x(ncmax),y(ncmax)
      call ABFL2 (a,b,z,kq,ksat,ab,
     &            tbub,tdew,pbub,pdew,Dlbub,Dvdew,ybub,xdew,
     &            t,p,Dl,Dv,x,y,q,ierr,herr)
      end
c ======================================================================
      subroutine DBFL2dll (d,b,z,kq,ab,t,p,Dl,Dv,x,y,q,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*2 ab
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DBFL2dll"::DBFL2dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DBFL2dll
      !dll_export DBFL2dll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call DBFL2 (d,b,z,kq,ab,t,p,Dl,Dv,x,y,q,ierr,herr)
      end
c ======================================================================
      subroutine TQFLSHdll (t,q,z,kq,p,D,Dl,Dv,x,y,e,h,s,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TQFLSHdll"::TQFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TQFLSHdll
      !dll_export TQFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call TQFLSH (t,q,z,kq,p,D,Dl,Dv,x,y,e,h,s,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine PQFLSHdll (p,q,z,kq,t,D,Dl,Dv,x,y,e,h,s,cv,cp,w,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PQFLSHdll"::PQFLSHdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PQFLSHdll
      !dll_export PQFLSHdll
      dimension z(ncmax),x(ncmax),y(ncmax)
      call PQFLSH (p,q,z,kq,t,D,Dl,Dv,x,y,e,h,s,cv,cp,w,i,herr)
      end
c ======================================================================
      subroutine CSTARdll (t,p,v,x,cs,ts,Ds,ps,ws,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CSTARdll"::CSTARdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CSTARdll
      !dll_export CSTARdll
      dimension x(ncmax)
      call CSTAR (t,p,v,x,cs,ts,Ds,ps,ws,ierr,herr)
      end
c ======================================================================
      subroutine CCRITdll (t,p,v,x,cs,ts,Ds,ps,ws,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CCRITdll"::CCRITdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CCRITdll
      !dll_export CCRITdll
      dimension x(ncmax)
      call CSTAR (t,p,v,x,cs,ts,Ds,ps,ws,ierr,herr)
      end
c ======================================================================
      subroutine FPVdll (t,rho,p,x,f)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_FPVdll"::FPVdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::FPVdll
      !dll_export FPVdll
      dimension x(ncmax)
      call FPV (t,rho,p,x,f)
      end
c ======================================================================
      subroutine CP0dll (t,x,cp)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_CP0dll"::CP0dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::CP0dll
      !dll_export CP0dll
      dimension x(ncmax)
      cp=CP0(t,x)
      end
c ======================================================================
      subroutine TRNPRPdll (t,rho,x,eta,tcx,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_TRNPRPdll"::TRNPRPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::TRNPRPdll
      !dll_export TRNPRPdll
      dimension x(ncmax)
      call TRNPRP (t,rho,x,eta,tcx,ierr,herr)
      if (tcx.gt.1.d50) tcx=0             !Avoid NaN (not a number)
      if (eta.gt.1.d50) eta=0             !Avoid NaN (not a number)
      end
c ======================================================================
      subroutine INFOdll (icomp,wmm,ttrp,tnbpt,tc,pc,Dc,Zc,acf,dip,Rgas)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_INFOdll"::INFOdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::INFOdll
      !dll_export INFOdll
      call INFO (icomp,wmm,ttrp,tnbpt,tc,pc,Dc,Zc,acf,dip,Rgas)
      end
c ======================================================================
      subroutine NAMEdll (icomp,hname,hn80,hcas)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*12 hcas,hname
      character*80 hn80
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_NAMEdll"::NAMEdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::NAMEdll
      !dll_export NAMEdll
      call NAME (icomp,hname,hn80,hcas)
      end
c ======================================================================
      subroutine XMASSdll (xmol,xkg,wmix)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_XMASSdll"::XMASSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::XMASSdll
      !dll_export XMASSdll
      dimension xmol(ncmax),xkg(ncmax)
      call XMASS (xmol,xkg,wmix)
      end
c ======================================================================
      subroutine XMOLEdll (xkg,xmol,wmix)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_XMOLEdll"::XMOLEdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::XMOLEdll
      !dll_export XMOLEdll
      dimension xmol(ncmax),xkg(ncmax)
      call XMOLE (xkg,xmol,wmix)
      end
c ======================================================================
      subroutine LIMITXdll (htyp,t,D,p,x,tmin,tmax,Dmax,pmax,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*3 htyp
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_LIMITXdll"::LIMITXdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::LIMITXdll
      !dll_export LIMITXdll
      dimension x(ncmax)
      call LIMITX (htyp,t,D,p,x,tmin,tmax,Dmax,pmax,ierr,herr)
      end
c ======================================================================
      subroutine LIMITKdll (htyp,icomp,t,D,p,tmin,tmax,Dmax,pmax,i,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*3 htyp
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_LIMITKdll"::LIMITKdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::LIMITKdll
      !dll_export LIMITKdll
      call LIMITK (htyp,icomp,t,D,p,tmin,tmax,Dmax,pmax,i,herr)
      end
c ======================================================================
      subroutine LIMITSdll (htyp,x,tmin,tmax,Dmax,pmax)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*3 htyp
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_LIMITSdll"::LIMITSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::LIMITSdll
      !dll_export LIMITSdll
      dimension x(ncmax)
      call LIMITS (htyp,x,tmin,tmax,Dmax,pmax)
      end
c ======================================================================
      subroutine QMASSdll (qmol,xl,xv,qkg,xlkg,xvkg,wliq,wvap,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_QMASSdll"::QMASSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::QMASSdll
      !dll_export QMASSdll
      dimension xl(ncmax),xv(ncmax),xlkg(ncmax),xvkg(ncmax)
      call QMASS (qmol,xl,xv,qkg,xlkg,xvkg,wliq,wvap,ierr,herr)
      end
c ======================================================================
      subroutine QMOLEdll (qkg,xlkg,xvkg,qmol,xl,xv,wliq,wvap,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_QMOLEdll"::QMOLEdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::QMOLEdll
      !dll_export QMOLEdll
      dimension xl(ncmax),xv(ncmax),xlkg(ncmax),xvkg(ncmax)
      call QMOLE (qkg,xlkg,xvkg,qmol,xl,xv,wliq,wvap,ierr,herr)
      end
c ======================================================================
      subroutine WMOLdll (x, wm)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_WMOLdll"::WMOLdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::WMOLdll
      !dll_export WMOLdll
      dimension x(ncmax)
      wm=WMOL(x)
      end
c ======================================================================
      subroutine DIELECdll (t,rho,x,de)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DIELECdll"::DIELECdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DIELECdll
      !dll_export DIELECdll
      dimension x(ncmax)
      call DIELEC (t,rho,x,de)
      end
c ======================================================================
      subroutine SURFTdll (t,rho,x,sigma,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SURFTdll"::SURFTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SURFTdll
      !dll_export SURFTdll
      dimension x(ncmax)
      call SURFT (t,rho,x,sigma,ierr,herr)
      end
c ======================================================================
      subroutine EXCESSdll (t,p,x,kph,rho,vE,eE,hE,sE,aE,gE,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_EXCESSdll"::EXCESSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::EXCESSdll
      !dll_export EXCESSdll
      dimension x(ncmax)
      call EXCESS (t,p,x,kph,rho,vE,eE,hE,sE,aE,gE,ierr,herr)
      end
c ======================================================================
      subroutine SURTENdll (t,rhol,rhov,xl,xv,sigma,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SURTENdll"::SURTENdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SURTENdll
      !dll_export SURTENdll
      dimension xl(ncmax),xv(ncmax)
      call SURTEN (t,rhol,rhov,xl,xv,sigma,ierr,herr)
      end
c ======================================================================
      subroutine PDFL1dll (p,rho,x,t,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PDFL1dll"::PDFL1dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PDFL1dll
      !dll_export PDFL1dll
      dimension x(ncmax)
      call PDFL1 (p,rho,x,t,ierr,herr)
      end
c ======================================================================
      subroutine PHFL1dll (p,h,x,kph,t,D,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PHFL1dll"::PHFL1dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PHFL1dll
      !dll_export PHFL1dll
      dimension x(ncmax)
      call PHFL1 (p,h,x,kph,t,D,ierr,herr)
      end
c ======================================================================
      subroutine PSFL1dll (p,s,x,kph,t,D,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PSFL1dll"::PSFL1dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PSFL1dll
      !dll_export PSFL1dll
      dimension x(ncmax)
      call PSFL1 (p,s,x,kph,t,D,ierr,herr)
      end
c ======================================================================
      subroutine SETKTVdll (icomp,jcomp,hmodij,fij,hfmix,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (nmxpar=6)
      character*3 hmodij
      character*255 hfmix,herr
      dimension fij(nmxpar)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETKTVdll"::SETKTVdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETKTVdll
      !dll_export SETKTVdll
      call SETKTV (icomp,jcomp,hmodij,fij,hfmix,ierr,herr)
      end
c ======================================================================
      subroutine GETKTVdll (icomp,jcomp,hmodij,fij,hfmix,hfij2,hbinp,
     &                      hmxrul)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (nmxpar=6)
      character*3 hmodij
      character*8 hfij(nmxpar)
      character*255 hfmix,hmxrul,hbinp,hfij2
      dimension fij(nmxpar)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_GETKTVdll"::GETKTVdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::GETKTVdll
      !dll_export GETKTVdll
      call GETKTV (icomp,jcomp,hmodij,fij,hfmix,hfij,hbinp,hmxrul)
      hfij2=hfij(1)//hfij(2)//hfij(3)//hfij(4)//hfij(5)//hfij(6)
      end
c ======================================================================
      subroutine GETFIJdll (hmodij,fij,hfij2,hmxrul)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (nmxpar=6)
      character*3 hmodij
      character*8 hfij(nmxpar)
      character*255 hmxrul,hfij2
      dimension fij(nmxpar)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_GETFIJdll"::GETFIJdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::GETFIJdll
      !dll_export GETFIJdll
      call GETFIJ (hmodij,fij,hfij,hmxrul)
      hfij2=hfij(1)//hfij(2)//hfij(3)//hfij(4)//hfij(5)//hfij(6)
      end
c ======================================================================
      subroutine MELTTdll (t,x,p,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_MELTTdll"::MELTTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::MELTTdll
      !dll_export MELTTdll
      dimension x(ncmax)
      call MELTT (t,x,p,ierr,herr)
      end
c ======================================================================
      subroutine MLTH2Odll (t,p1,p2)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_MLTH2Odll"::MLTH2Odll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::MLTH2Odll
      !dll_export MLTH2Odll
      call MLTH2O (t,p1,p2)
      end
c ======================================================================
      subroutine MELTPdll (p,x,t,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_MELTPdll"::MELTPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::MELTPdll
      !dll_export MELTPdll
      dimension x(ncmax)
      call MELTP (p,x,t,ierr,herr)
      end
c ======================================================================
      subroutine SUBLTdll (t,x,p,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SUBLTdll"::SUBLTdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SUBLTdll
      !dll_export SUBLTdll
      dimension x(ncmax)
      call SUBLT (t,x,p,ierr,herr)
      end
c ======================================================================
      subroutine SUBLPdll (p,x,t,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SUBLPdll"::SUBLPdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SUBLPdll
      !dll_export SUBLPdll
      dimension x(ncmax)
      call SUBLP (p,x,t,ierr,herr)
      end
c ======================================================================
      subroutine PREOSdll (i)
      implicit integer (i-n)
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_PREOSdll"::PREOSdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::PREOSdll
      !dll_export PREOSdll
      call PREOS (i)
      end
c ======================================================================
      subroutine SETAGAdll (ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_SETAGAdll"::SETAGAdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::SETAGAdll
      !dll_export SETAGAdll
      call SETAGA (ierr,herr)
      end
c ======================================================================
      subroutine GERG04dll (nc,iflag,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_GERG04dll"::GERG04dll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::GERG04dll
      !dll_export GERG04dll
      call GERG04 (nc,iflag,ierr,herr)
      end
c ======================================================================
      subroutine DOTFILLdll (x,ptest,filrat,ierr,herr)
      implicit double precision (a-h,o-z)
      implicit integer (i-n)
      parameter (ncmax=20)
      character*255 herr
cDEC$ ATTRIBUTES DLLEXPORT, Alias: "_DOTFILLdll"::DOTFILLdll
cDEC$ ATTRIBUTES STDCALL, REFERENCE::DOTFILLdll
      !dll_export DOTFILLdll
      dimension x(ncmax)
      call DOTFILL (x,ptest,filrat,ierr,herr)
      end
