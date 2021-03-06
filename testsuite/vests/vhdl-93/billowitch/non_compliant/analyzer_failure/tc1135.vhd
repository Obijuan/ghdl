
-- Copyright (C) 2001 Bill Billowitch.

-- Some of the work to develop this test suite was done with Air Force
-- support.  The Air Force and Bill Billowitch assume no
-- responsibilities for this software.

-- This file is part of VESTs (Vhdl tESTs).

-- VESTs is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at
-- your option) any later version. 

-- VESTs is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-- for more details. 

-- You should have received a copy of the GNU General Public License
-- along with VESTs; if not, write to the Free Software Foundation,
-- Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 

-- ---------------------------------------------------------------------
--
-- $Id: tc1135.vhd,v 1.2 2001-10-26 16:30:06 paw Exp $
-- $Revision: 1.2 $
--
-- ---------------------------------------------------------------------

ENTITY c06s05b00x00p04n01i01135ent IS
END c06s05b00x00p04n01i01135ent;

ARCHITECTURE c06s05b00x00p04n01i01135arch OF c06s05b00x00p04n01i01135ent IS

BEGIN
  TESTING: PROCESS
    type ENUM1 is (M1, M2, M3, M4, M5);
    type ENUM2 is (N1, N2, N3, N4, N5);
    type FIVE1 is range 1 to 5;
    type FIVE2 is range 1 to 5;
    variable VE1LOW: ENUM1 := M2;
    variable VE2HIGH: ENUM2 := N4;
    variable VF1LOW: FIVE1 := 2;
    variable VF2HIGH: FIVE2 := 4;
    type AE5 is array (M1 to M5) of BOOLEAN;
    type AF5 is array (FIVE1) of BOOLEAN;
    variable VAE5: AE5 ;
    variable VAF5: AF5 ;
  BEGIN
    VAE5(M2 to M4) := VAE5(VE1LOW to VE2HIGH);
    -- SEMANTIC ERROR: BOUNDS OF DISCRETE RANGE MUST BE OF SAME TYPE
    assert FALSE 
      report "***FAILED TEST: c06s05b00x00p04n01i01135 - Bounds of discrete ranges must be of same type." 
      severity ERROR;
    wait;
  END PROCESS TESTING;

END c06s05b00x00p04n01i01135arch;
