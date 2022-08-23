
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
