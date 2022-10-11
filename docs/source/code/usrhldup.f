


      IF (USRCOR .EQ. 1) THEN
              RHOL = AVMWLI*DENMXL
              UL = FRATEL/DENMXL/TWRARA
              
              HT=REAL(1)*(3.185966*(VISCML/RHOL)**0.3333*(UL))
       +**REAL(2)
            
              LHLDUP = HT * TWRARA * HTPACK
              VHLDUP = (1D0 - HT - VOIDFR) * TWRARA * HTPACK
      END IF