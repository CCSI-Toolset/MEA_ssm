
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
      