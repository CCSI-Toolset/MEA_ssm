
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
c       LIQUID PHASE
      EXPKD = 0.50
      PREK = CL*(9.81*rhoLms/VISCML)**0.16666667*(1/HYDDIAM)**0.5
      PREK = PREK*(uL/SPAREA)**0.333333333
      PREK=PREK*TWRARA*HTPACK*AREAIF*DENMXL
      ELSE
c       VAPOR PHASE
      PREK = CV*(SPAREA/HYDDIAM)**0.5
      PREK = PREK*(VISCMV/rhoVms)**0.3333333333333
      PREK = PREK*(uV*rhoVms/(VISCMV*SPAREA))**0.75
      PREK = PREK/(VOIDFR-HOLDL)**0.5
      PREK=PREK*TWRARA*HTPACK*AREAIF*DENMXV
      EXPKD = 0.66666666667
