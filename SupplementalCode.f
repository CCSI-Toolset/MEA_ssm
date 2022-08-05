      
      
C     mul2u2.f      
      INTEGER DMS_KCCIDC,I
      INTEGER IH2O,IMEA,IMEACOO,ICO2,IMEAH,IHCO3
      REAL*8 XX(100),SUM,DSUM,DPSUM
      REAL*8 A,B,C,D,E,F,G
      REAL*8 MUW,XCO2T,XMEAT,XH2OT,LDG,WTMEA,MUBLEND
      
      IH2O = DMS_KCCIDC('H2O')
      IMEA = DMS_KCCIDC('MEA')
      IMEACOO = DMS_KCCIDC('MEACOO-')
      ICO2 = DMS_KCCIDC('CO2')
      IMEAH = DMS_KCCIDC('MEA+')
      IHCO3 = DMS_KCCIDC('HCO3-')
      
      DO I=1,100
          XX(I) = 0
      END DO
      
      DO I=1,N
          IF (IDX(I). EQ. IH2O) XX(IH2O) = Z(I)
          IF (IDX(I). EQ. IMEA) XX(IMEA) = Z(I)
          IF (IDX(I). EQ. IMEACOO) XX(IMEACOO) = Z(I)
          IF (IDX(I). EQ. ICO2) XX(ICO2) = Z(I)
          IF (IDX(I). EQ. IMEAH) XX(IMEAH) =Z(I)
          IF (IDX(I). EQ. IHCO3) XX(IHCO3) = Z(I)
      END DO
      
      A = MULU2A(1,IMEA)
      B = MULU2A(2,IMEA)
      C = MULU2A(3,IMEA)
      D = MULU2A(4,IMEA)
      E = MULU2A(5,IMEA)
      F = MULU2A(1,IH2O)
      G = MULU2A(2,IH2O)
      
      MUW = 1.002
      MUW=MUW*10**(1.3272*(293.15-T-0.001053*(T-293.15)**2)/(T-168.15))
      
      XCO2T = XX(IMEACOO) + XX(IHCO3) + XX(ICO2)
      XMEAT = XX(IMEACOO) + XX(IMEAH) + XX(IMEA)
      XH2OT = XX(IHCO3) + XX(IH2O)
      
      LDG = XCO2T/XMEAT     
      WTMEA = XMEAT*XMW(IMEA) + XH2OT*XMW(IH2O)
      WTMEA = 100*((XMEAT*XMW(IMEA))/WTMEA)
      
      MUBLEND=(A*WTMEA+B)*T+(C*WTMEA+D)
      MUBLEND=MUBLEND*(LDG*(E*WTMEA+F*T+G)+1)*WTMEA
      MUBLEND=DEXP(MUBLEND/T**2)
      
      IF (XMEAT.EQ.0) THEN
           SUM=MUI(IH2O)
      ELSE IF (XH2OT.EQ.0) THEN
          SUM=DEXP(-102.07+7992.1/T+13.724*LOG(T))/1000
      ELSE 
          SUM=MUBLEND*MUW/1000
      END IF

C     vl2u2.f

      INTEGER DMS_KCCIDC,I
      INTEGER IH2O,IMEA,IMEACOO,ICO2,IMEAH,IHCO3
      REAL*8 XX(100),SUM,DSUM,DPSUM
      REAL*8 A,B,C,D,E
      REAL*8 AM,BM,CM,AW,BW,CW
      REAL*8 VH2O,VMEA
      REAL*8 XCO2T,XMEAT,XH2OT,XTOT
      REAL*8 XCO2,XMEA,XH2O

      IH2O = DMS_KCCIDC('H2O')
      IMEACOO = DMS_KCCIDC('MEACOO-')
      ICO2 = DMS_KCCIDC('CO2')
      IMEAH = DMS_KCCIDC('MEA+')
      IHCO3  = DMS_KCCIDC('HCO3-')
      IMEA = DMS_KCCIDC('MEA')  
    
      DO I=1,100
          XX(I) = 0
      END DO
      
      DO I=1,N
          IF (IDX(I). EQ. IH2O) XX(IH2O) = Z(I)
          IF (IDX(I). EQ. IMEA) XX(IMEA) = Z(I)
          IF (IDX(I). EQ. IMEACOO) XX(IMEACOO) = Z(I)
          IF (IDX(I). EQ. ICO2) XX(ICO2) = Z(I)
          IF (IDX(I). EQ. IMEAH) XX(IMEAH) =Z(I)
          IF (IDX(I). EQ. IHCO3) XX(IHCO3) = Z(I)
      END DO
      
      A = VL2U2A(1,IMEA)
      B = VL2U2A(2,IMEA)
      C = VL2U2A(3,IMEA)
      D = VL2U2A(4,IMEA)
      E = VL2U2A(5,IMEA)
      
      AM=-0.000000535162
      BM=-0.000451417
      CM=1.19451
      AW=-0.00000324839
      BW=0.00165311
      CW=0.793041

      VH2O = XMW(IH2O)/(AW*T**2+BW*T+CW)
      VMEA = XMW(IMEA)/(AM*T**2+BM*T+CM)
      XCO2T = XX(IMEACOO) + XX(IHCO3) + XX(ICO2)
      XMEAT = XX(IMEACOO) + XX(IMEAH) + XX(IMEA)
      XH2OT = XX(IHCO3) + XX(IH2O)
      XTOT = XCO2T+XMEAT+XH2OT
      
      XCO2 = XCO2T/XTOT
      XMEA = XMEAT/XTOT
      XH2O = XH2OT/XTOT
      
      SUM = XMEA*VMEA + XH2O*VH2O + XCO2*A + XMEA*XH2O*(B+C*XMEA)
      SUM = SUM+XMEA*XCO2*(D+E*XMEA)
      
      IF (XMEA.EQ.0) THEN
           SUM=VI(IH2O)
      ELSE IF (XH2O.EQ.0) THEN
          SUM=VMEA/1000
      ELSE 
          SUM=SUM/1000
      END IF
      
      DSUM=0D0
      DPSUM=0D0

      
C     sig2u2.f
      
      INTEGER DMS_KCCIDC,I
      INTEGER IH2O,IMEA,IMEACOO,ICO2,IMEAH,IHCO3
      REAL*8 XX(100),SUM,DSUM,DPSUM
      REAL*8 A,B,C,D,E,F,G,H,K,J
      REAL*8 S1,S2,S3,S4,S5,S6
      REAL*8 C1W,C1M,C2W,C2M,C3W,C3M,C4W,C4M,TCW,TCM
      REAL*8 XMEAT,XCO2T,XH2OT
      REAL*8 XMEA,XCO2,XH2O,LDG,WTMEA
      REAL*8 FXNF,FXNG,SIGCO2,SIGH2O,SIGMEA

      IH2O = DMS_KCCIDC('H2O')
      IMEA = DMS_KCCIDC('MEA')
      IMEACOO = DMS_KCCIDC('MEACOO-')
      ICO2 = DMS_KCCIDC('CO2')
      IMEAH = DMS_KCCIDC('MEA+')
      IHCO3 = DMS_KCCIDC('HCO3-')
      
      DO I=1,100
          XX(I) = 0
      END DO
      
      DO I=1,N
          IF (IDX(I). EQ. IH2O) XX(IH2O) = Z(I)
          IF (IDX(I). EQ. IMEA) XX(IMEA) = Z(I)
          IF (IDX(I). EQ. IMEACOO) XX(IMEACOO) = Z(I)
          IF (IDX(I). EQ. ICO2) XX(ICO2) = Z(I)
          IF (IDX(I). EQ. IMEAH) XX(IMEAH) =Z(I)
          IF (IDX(I). EQ. IHCO3) XX(IHCO3) = Z(I)
      END DO
      
      A=SIGU2A(1,IMEA)
      B=SIGU2A(2,IMEA)
      C=SIGU2A(3,IMEA)
      D=SIGU2A(4,IMEA)
      E=SIGU2A(5,IMEA)
      F=SIGU2A(1,IH2O)
      G=SIGU2A(2,IH2O)
      H=SIGU2A(3,IH2O)
      K=SIGU2A(4,IH2O)
      J=SIGU2A(5,IH2O)
      
      
      S1=-5.987
      S2=3.7699
      S3=-0.43164
      S4=0.018155
      S5=-0.01207
      S6=0.002119
      C1W=0.18548
      C1M=0.09945
      C2W=2.717
      C2M=1.067
      C3W=-3.554
      C3M=0
      C4W=2.047
      C4M=0
      TCW=647.13
      TCM=614.45
      
      XCO2T=XX(IMEACOO)+XX(IHCO3)+XX(ICO2)
      XMEAT=XX(IMEACOO)+XX(IMEAH)+XX(IMEA)
      XH2OT=XX(IH2O)+XX(IHCO3)
      WTMEA=(XMW(IMEA)*XMEAT)/(XMW(IMEA)*XMEAT+XMW(IH2O)*XH2OT)
      LDG=XCO2T/XMEAT
      XMEA=(1+LDG+(XMW(IMEA)/XMW(IH2O))*(1-WTMEA)/WTMEA)**(-1)
      XCO2=XMEA*LDG
      XH2O=1-XMEA-XCO2
      
      FXNF=A+B*LDG+C*LDG**2+D*WTMEA+E*WTMEA**2
      FXNG=F+G*LDG+H*LDG**2+K*WTMEA+J*WTMEA**2
      SIGCO2=S1*WTMEA**2+S2*WTMEA+S3+T*(S4*WTMEA**2+S5*WTMEA+S6)
      SIGH2O=C1W*(1-T/TCW)**(C2W+C3W*(T/TCW)+C4W*(T/TCW)**2)
      SIGMEA=C1M*(1-T/TCM)**(C2M+C3M*(T/TCM)+C4M*(T/TCM)**2)
      
      
      SUM=SIGH2O+(SIGCO2-SIGH2O)*FXNF*XCO2+(SIGMEA-SIGH2O)*FXNG*XMEA
      
      IF (XMEAT.EQ.0) THEN
          SUM=STI(IH2O)
      ELSE IF (XH2OT.EQ.0) THEN
          SUM=SIGMEA
      ELSE 
          SUM=SUM
      END IF
      
      DSUM=0D0
      DPSUM=0D0
      
C     dl0u.f
      
#include "dms_plex.cmn"

      INTEGER DMS_KCCIDC,DMS_IFCMNC,NBOPST(6),NAME(2)
      INTEGER IH2O,IMEA,IMEACOO,ICO2,IMEAH,IHCO3,IN2,IO2
      REAL*8 VISC,MUMX
      REAL*8 E,MU0,THET,A,BB,C,R,HG,MUW
      REAL*8 B(1)
      EQUIVALENCE (B(1),IB(1))
      INTEGER DFACT_IDX,EFACT_IDX
      REAL*8 DFACTCO2,DFACTMEA,EFACT,CO2DW,CO2D,MEAD

      IH2O = DMS_KCCIDC('H2O')
      IMEA = DMS_KCCIDC('MEA')
      IMEACOO = DMS_KCCIDC('MEACOO-')
      ICO2 = DMS_KCCIDC('CO2')
      IMEAH = DMS_KCCIDC('MEA+')
      IHCO3 = DMS_KCCIDC('HCO3-')
      IN2 = DMS_KCCIDC('N2')
	IO2 = DMS_KCCIDC('O2')  

      CALL PPUTL_GOPSET(NBOPST,NAME)
      CALL PPMON_VISCL (T, P, X, N, IDX, NBOPST, KDIAG, VISC, KER)
      MUMX = VISC

      E = 4.753D0
      MU0 = 0.000024055D0
      THET = 139.7D0	
	A = 0.000442D0
	BB = 0.0009565D0
	C = 0.0124D0
	R = 0.008314D0
	P = P / 100000D0

      
      HG = A * P +((E - BB * P)/(R * (T - THET - C * P)))
	MUW = (MU0 * EXP(HG))
      
      DFACT_IDX = DMS_IFCMNC('DFACT1')
      EFACT_IDX = DMS_IFCMNC('EFACT')
      
      DFACTCO2 = B(DFACT_IDX+IDX(ICO2))
      DFACTMEA = B(DFACT_IDX+IDX(IMEA))
      EFACT = B(EFACT_IDX+IDX(ICO2))
      
      CO2DW = 0.00000235D0*EXP(-2119D0/T)
      CO2D = CO2DW * (MUW / MUMX)**(0.8D0)*((T/313.15)**(EFACT))
      CO2D = CO2D * DFACTCO2
      CO2D = ((DFACTCO2)**2)/DFACTMEA * (MUW/MUMX)**0.8
      CO2D = CO2D*(T/313.15)**(EFACT)
      
      MEAD = (1/((MUMX/MUW)**0.8D0))*((T/313.15)**(EFACT))
      MEAD = MEAD * DFACTMEA
      
      DO 200 I = 1, N
        DO 100 J = 1, N
          IF (I.EQ.J) THEN
            QBIN(I,J) = 0D0
           
          ELSE
            QBIN(I,J) = MEAD
           
            IF (I.EQ.ICO2)QBIN(I,J) = CO2D
            IF (J.EQ.ICO2)QBIN(I,J) = CO2D
            IF (I.EQ.IN2)QBIN(I,J) = CO2D
            IF (J.EQ.IN2)QBIN(I,J) = CO2D      
          END IF
  100   CONTINUE
  200 CONTINUE

      
C     usrknt.f
      
#include "dms_rglob.cmn"
#include "dms_lclist.cmn"
#include "pputl_ppglob.cmn"
#include "dms_ipoff3.cmn"
#include "dms_plex.cmn"
      EQUIVALENCE(IB(1),B(1))

      
      INTEGER I,K,FN,L_GAMMA,L_GAMUS,GAM,US,DMS_KFORMC,KPHI,KER
      INTEGER DMS_ALIPOFF3,IHELGK
      REAL*8 B(1)
      REAL*8 N_H2O,N_CO2,N_MEA,N_MEAH,N_MEAC,N_HCO3
      REAL*8 PHI(100),DPHI(100),GAMMA(100),COEFFCO2,COEFFMEA
      REAL*8 ACCO2,ACMEA,ACH2O,ACMEAH,ACMEAC,ACHCO3,R,STOI(100),LNRKO
      REAL*8 DUM,KEQ1,KEQ2,RXNRATES(100)

      FN(I) = I+LCLIST_LBLCLIST
      L_GAMMA(I) = FN(GAM) + I
      L_GAMUS(I) = FN(US) + I
      
      N_H2O   = DMS_KFORMC('H2O')
      N_CO2   = DMS_KFORMC('CO2')
      N_MEA    = DMS_KFORMC('C2H7NO')
      N_MEAH  = DMS_KFORMC('C2H8NO+')
      N_MEAC = DMS_KFORMC('C3H6NO3-')
      N_HCO3 = DMS_KFORMC('HCO3-')

	T = TLIQ
      
      KPHI = 1
      CALL PPMON_FUGLY(T,P,X,Y,NCOMP,IDX,NBOPST,KDIAG,KPHI,PHI,DPHI,KER)
      
      GAM = DMS_ALIPOFF3(24)
      
      DO I=1,NCOMP
      GAMMA(I)=1.D0
      IF (INT(1).EQ.1) GAMMA(I) = DEXP(B(L_GAMMA(I)))
      END DO
      
      US = DMS_ALIPOFF3(29)
      
      COEFFCO2 = DEXP(B(L_GAMUS(N_CO2)))
      COEFFMEA = DEXP(B(L_GAMUS(N_MEA)))
      
      ACCO2 = COEFFCO2*X(N_CO2,1)
      ACMEA = COEFFMEA*X(N_MEA,1)
      ACH2O = GAMMA(N_H2O)*X(N_H2O,1)
      ACMEAH = GAMMA(N_MEAH)*X(N_MEAH,1)
      ACMEAC = GAMMA(N_MEAC)*X(N_MEAC,1)
      ACHCO3 = GAMMA(N_HCO3)*X(N_HCO3,1)
      
      R = PPGLOB_RGAS/1000
      
      DO I=1,100
          STOI(I) = 0D0
      END DO
      
      DO I=1,NCOMP
          IF (IDX(I).EQ.N_MEA) STOI(I)=-2D0
          IF (IDX(I).EQ.N_CO2) STOI(I)=-1D0
          IF (IDX(I).EQ.N_MEAH) STOI(I)=1D0
          IF (IDX(I).EQ.N_MEAC) STOI(I)=1D0
      END DO
      
      LNRKO = RGLOB_RMISS
      
      CALL PPELC_ZKEQ(T,1,1,0,STOI,0D0,NCOMP,IDX,0,1,1,NBOPST,KDIAG,
     2 LNRKO,P,IHELGK,DUM,0,0,0)
      
      KEQ1 = DEXP(LNRKO)
      
      DO I=1,100
          STOI(I) = 0D0
      END DO
      
      DO I=1,NCOMP
          IF (IDX(I).EQ.N_MEA) STOI(I)=-1D0
          IF (IDX(I).EQ.N_CO2) STOI(I)=-1D0
          IF (IDX(I).EQ.N_H2O) STOI(I)=-1D0
          IF (IDX(I).EQ.N_MEAH) STOI(I)=1D0
          IF (IDX(I).EQ.N_HCO3) STOI(I)=1D0
      ENDDO
      
      LNRKO = RGLOB_RMISS
      
      CALL PPELC_ZKEQ(T,1,1,0,STOI,0D0,NCOMP,IDX,0,1,1,NBOPST,KDIAG,
     2 LNRKO,P,IHELGK,DUM,0,0,0)
      
      KEQ2 = DEXP(LNRKO)
      
      RXNRATES(1)=REAL(1)*DEXP(-REAL(3)/R*(1/TLIQ-1/298.15))*
     2 (ACMEA**2*ACCO2-ACMEAC*ACMEAH/KEQ1)
      RXNRATES(2)=REAL(2)*DEXP(-REAL(4)/R*(1/TLIQ-1/298.15))*
     2 (ACMEA*ACCO2-ACMEAH*ACHCO3/(KEQ2*ACH2O))
      
      DO K=1,NRL(1)
          RXNRATES(K) = RXNRATES(K)*HLDLIQ
          RATEL(K) = RXNRATES(K)
      END DO
      
      DO I=1,NCOMP
          RATES(I)=0.D0
      END DO
      
      DO K=1,NRL(1)
          DO I=1,NCOMP
              IF (DABS(STOIC(I,K)).GE.RGLOB_RMIN) RATES(I) = RATES(I) + 
     2            STOIC(I,K)*RXNRATES(K)
          END DO
      END DO

C     usrmtrfc.f

      REAL*8 CL,CV,HYDDIAM,HOLDL
      
      CL=REAL(1)
      CV=REAL(2)
      HYDDIAM=4*VOIDFR/SPAREA
      rhoLms = DENMXL*AVMWLI
      uL = FRATEL / TWRARA / DENMXL
      rhoVms = DENMXV*AVMWVA
      uV = FRATEV/TWRARA/DENMXV
      HOLDL = (12*VISCML*uL*SPAREA**2/(9.81*rhoLms))**0.3333333         
      IF (IPHASE.EQ.0) THEN
c     LIQUID PHASE
      EXPKD = 0.50
      PREK = CL*(9.81*rhoLms/VISCML)**0.16666667*(1/HYDDIAM)**0.5
      PREK = PREK*(uL/SPAREA)**0.333333333
      PREK=PREK*TWRARA*HTPACK*AREAIF*DENMXL
      ELSE
c     VAPOR PHASE
      PREK = CV*(SPAREA/HYDDIAM)**0.5
      PREK = PREK*(VISCMV/rhoVms)**0.3333333333333
      PREK = PREK*(uV*rhoVms/(VISCMV*SPAREA))**0.75
      PREK = PREK/(VOIDFR-HOLDL)**0.5
      PREK=PREK*TWRARA*HTPACK*AREAIF*DENMXV
      EXPKD = 0.66666666667

C     usrintfa.f
      REAL*8 Aa,Bb
      
      Aa = REAL(2)
      Bb = REAL(3)
      dTemp = Aa*((WeL*FrL**(-1/3))**Bb)
      
C     usrhldup.f
      
      IF (USRCOR .EQ. 1) THEN
              RHOL = AVMWLI*DENMXL
              UL = FRATEL/DENMXL/TWRARA
              
              HT=REAL(1)*(3.185966*(VISCML/RHOL)**0.3333*(UL))
     +**REAL(2)
          
              LHLDUP = HT * TWRARA * HTPACK
              VHLDUP = (1D0 - HT - VOIDFR) * TWRARA * HTPACK
      END IF

