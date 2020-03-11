CREATE OR REPLACE FUNCTION isHoliday(myDay IN DATE, n IN INTEGER,HorW  OUT VARCHAR2,
error_message OUT VARCHAR2) RETURN BOOLEAN AS

       l_day NUMBER;
       l_month NUMBER;
       l_year NUMBER;
       l_return BOOLEAN;
       
  /*   CURSOR dd_mm_yy IS
              SELECT EXTRACT(DAY FROM myDay+n),
                     EXTRACT(MONTH FROM myDay+n),
                     EXTRACT(YEAR FROM myDay+n)
              FROM dual;
              
       CURSOR w_h  IS 
         SELECT substr(holiday_list, l_day, 1) FROM STTMS_LCL_HOLIDAY
         WHERE month =l_month AND year = l_year;*/
       
       BEGIN
         
       l_day:=EXTRACT(DAY FROM myDay+n);
       l_month:=EXTRACT(MONTH FROM myDay+n);
       l_year:=EXTRACT(YEAR FROM myDay+n);
       
       
         BEGIN
           SELECT substr(holiday_list, l_day, 1)
                  INTO HorW
           FROM STTMS_LCL_HOLIDAY
           WHERE month =l_month AND year = l_year AND branch_code = 403;
         EXCEPTION
            WHEN OTHERS THEN         
              error_message := SQLERRM;
              DBMS_OUTPUT.PUT_LINE(error_message);
              DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
              RETURN FALSE;       
         END;
         
         
       /* OPEN dd_mm_yy;
         FETCH dd_mm_yy INTO l_day, l_month, l_year;

         OPEN w_h;
         FETCH w_h INTO HorW;
         CLOSE w_h;
         */
         
         IF HorW = 'W' THEN
           l_return :=FALSE;
         ELSE
           l_return :=TRUE;
         END IF;
         
         IF n<0 THEN
           DBMS_OUTPUT.PUT_LINE(abs(n)||' days before this day was '||HorW);
         ELSIF n>0 THEN
           DBMS_OUTPUT.PUT_LINE(abs(n)||' days after this day is '||HorW);
         ELSE 
           DBMS_OUTPUT.PUT_LINE('Today is '||HorW);
         END IF;
         
         RETURN l_return;
     EXCEPTION
       WHEN OTHERS THEN
         error_message := SQLERRM;
         DBMS_OUTPUT.PUT_LINE(SQLERRM);
         DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END isHoliday;
/
