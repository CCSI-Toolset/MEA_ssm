
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
      N_MEA      = DMS_KFORMC('C2H7NO')
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