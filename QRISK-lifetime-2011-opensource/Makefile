#
# Copyright 2010 ClinRisk Ltd. 
# 
# QRISK-lifetime-2011 is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# QRISK-lifetime-2011 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with QRISK-lifetime-2011.  If not, see <http://www.gnu.org/licenses/>.
# 
# The initial version of this file, to be found at http://qrisk.org/lifetime, faithfully implements QRISK-lifetime-2011.
# We have released this code under the GNU Lesser General Public License to enable others to implement the algorithm faithfully.  However, the nature of the GNU Lesser General Public License is such that we cannot prevent, for example, someone randomly permuting the coefficients. 
# We stress, therefore, that it is the responsibility of the end user to check that the source that they receive produces the same results as the original code posted at http://qrisk.org/lifetime.
# Inaccurate implementations of risk scores can lead to wrong patients being given the wrong treatment.
#

INCLUDES = 

# C++ compiler flags (-g -O2 -Wall)
CCFLAGS = -std=c99 -g

# compiler
CC = gcc

# library paths
LIBS = -lm

# compile flags
LDFLAGS = 

SOURCES = $(wildcard *.c)

.SUFFIXES: .c

default: depend executables

executables: Q65_lifetime_model_40_0_commandLine Q65_lifetime_model_40_1_commandLine 

Q65_lifetime_model_40_0_commandLine: Q65_lifetime_model_40_0_commandLine.o Q65_lifetime_model_40_cvd_0.o Q65_lifetime_model_40_death_0.o lifetimeRisk.o util.o

Q65_lifetime_model_40_1_commandLine: Q65_lifetime_model_40_1_commandLine.o Q65_lifetime_model_40_cvd_1.o Q65_lifetime_model_40_death_1.o lifetimeRisk.o util.o

.c:
	$(CC) $(INCLUDES) $(LDFLAGS) $< -o $@ $(LIBS)

.c.o:
	$(CC) $(INCLUDES) $(CCFLAGS) -c $< -o $@

depend:
	makedepend -- $(CFLAGS) -- $(INCLUDES) $(SOURCES)

clean:
	rm -f *.o *commandLine *.bak

# DO NOT DELETE

Q65_lifetime_model_40_0_commandLine.o: /usr/include/stdio.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/_types.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/_types.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/cdefs.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/machine/_types.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/i386/_types.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/secure/_stdio.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/secure/_common.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/stdlib.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/Availability.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/AvailabilityInternal.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/wait.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/signal.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/appleapiopts.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/machine/signal.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/i386/signal.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/i386/_structs.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/_structs.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/machine/_structs.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/resource.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/machine/endian.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/i386/endian.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/sys/_endian.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/libkern/_OSByteOrder.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/libkern/i386/_OSByteOrder.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/alloca.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/machine/types.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/i386/types.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/string.h
Q65_lifetime_model_40_0_commandLine.o: /usr/include/secure/_string.h
Q65_lifetime_model_40_0_commandLine.o: Q65_lifetime_model_40_cvd_0.h
Q65_lifetime_model_40_0_commandLine.o: Q65_lifetime_model_40_death_0.h
Q65_lifetime_model_40_0_commandLine.o: lifetimeRisk.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/stdio.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/_types.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/_types.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/cdefs.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/machine/_types.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/i386/_types.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/secure/_stdio.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/secure/_common.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/stdlib.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/Availability.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/AvailabilityInternal.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/wait.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/signal.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/appleapiopts.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/machine/signal.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/i386/signal.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/i386/_structs.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/_structs.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/machine/_structs.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/resource.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/machine/endian.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/i386/endian.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/sys/_endian.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/libkern/_OSByteOrder.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/libkern/i386/_OSByteOrder.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/alloca.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/machine/types.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/i386/types.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/string.h
Q65_lifetime_model_40_1_commandLine.o: /usr/include/secure/_string.h
Q65_lifetime_model_40_1_commandLine.o: Q65_lifetime_model_40_cvd_1.h
Q65_lifetime_model_40_1_commandLine.o: Q65_lifetime_model_40_death_1.h
Q65_lifetime_model_40_1_commandLine.o: lifetimeRisk.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/math.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/architecture/i386/math.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/sys/cdefs.h /usr/include/string.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/_types.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/sys/_types.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/machine/_types.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/i386/_types.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/secure/_string.h
Q65_lifetime_model_40_cvd_0.o: /usr/include/secure/_common.h
Q65_lifetime_model_40_cvd_0.o: Q65_lifetime_model_40_cvd_0.h util.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/math.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/architecture/i386/math.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/sys/cdefs.h /usr/include/string.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/_types.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/sys/_types.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/machine/_types.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/i386/_types.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/secure/_string.h
Q65_lifetime_model_40_cvd_1.o: /usr/include/secure/_common.h
Q65_lifetime_model_40_cvd_1.o: Q65_lifetime_model_40_cvd_1.h util.h
Q65_lifetime_model_40_death_0.o: /usr/include/math.h
Q65_lifetime_model_40_death_0.o: /usr/include/architecture/i386/math.h
Q65_lifetime_model_40_death_0.o: /usr/include/sys/cdefs.h
Q65_lifetime_model_40_death_0.o: /usr/include/string.h /usr/include/_types.h
Q65_lifetime_model_40_death_0.o: /usr/include/sys/_types.h
Q65_lifetime_model_40_death_0.o: /usr/include/machine/_types.h
Q65_lifetime_model_40_death_0.o: /usr/include/i386/_types.h
Q65_lifetime_model_40_death_0.o: /usr/include/secure/_string.h
Q65_lifetime_model_40_death_0.o: /usr/include/secure/_common.h
Q65_lifetime_model_40_death_0.o: Q65_lifetime_model_40_death_0.h util.h
Q65_lifetime_model_40_death_1.o: /usr/include/math.h
Q65_lifetime_model_40_death_1.o: /usr/include/architecture/i386/math.h
Q65_lifetime_model_40_death_1.o: /usr/include/sys/cdefs.h
Q65_lifetime_model_40_death_1.o: /usr/include/string.h /usr/include/_types.h
Q65_lifetime_model_40_death_1.o: /usr/include/sys/_types.h
Q65_lifetime_model_40_death_1.o: /usr/include/machine/_types.h
Q65_lifetime_model_40_death_1.o: /usr/include/i386/_types.h
Q65_lifetime_model_40_death_1.o: /usr/include/secure/_string.h
Q65_lifetime_model_40_death_1.o: /usr/include/secure/_common.h
Q65_lifetime_model_40_death_1.o: Q65_lifetime_model_40_death_1.h util.h
lifetimeRisk.o: /usr/include/stdlib.h /usr/include/Availability.h
lifetimeRisk.o: /usr/include/AvailabilityInternal.h /usr/include/_types.h
lifetimeRisk.o: /usr/include/sys/_types.h /usr/include/sys/cdefs.h
lifetimeRisk.o: /usr/include/machine/_types.h /usr/include/i386/_types.h
lifetimeRisk.o: /usr/include/sys/wait.h /usr/include/sys/signal.h
lifetimeRisk.o: /usr/include/sys/appleapiopts.h /usr/include/machine/signal.h
lifetimeRisk.o: /usr/include/i386/signal.h /usr/include/i386/_structs.h
lifetimeRisk.o: /usr/include/sys/_structs.h /usr/include/machine/_structs.h
lifetimeRisk.o: /usr/include/sys/resource.h /usr/include/machine/endian.h
lifetimeRisk.o: /usr/include/i386/endian.h /usr/include/sys/_endian.h
lifetimeRisk.o: /usr/include/libkern/_OSByteOrder.h
lifetimeRisk.o: /usr/include/libkern/i386/_OSByteOrder.h
lifetimeRisk.o: /usr/include/alloca.h /usr/include/machine/types.h
lifetimeRisk.o: /usr/include/i386/types.h /usr/include/stdio.h
lifetimeRisk.o: /usr/include/secure/_stdio.h /usr/include/secure/_common.h
lifetimeRisk.o: /usr/include/math.h /usr/include/architecture/i386/math.h
lifetimeRisk.o: lifetimeRisk.h
util.o: /usr/include/stdio.h /usr/include/_types.h /usr/include/sys/_types.h
util.o: /usr/include/sys/cdefs.h /usr/include/machine/_types.h
util.o: /usr/include/i386/_types.h /usr/include/secure/_stdio.h
util.o: /usr/include/secure/_common.h /usr/include/string.h
util.o: /usr/include/secure/_string.h util.h
