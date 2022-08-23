
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
      100 CONTINUE
      200 CONTINUE
