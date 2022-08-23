
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
