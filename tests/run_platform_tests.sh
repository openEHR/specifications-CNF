#!/usr/bin/env bash

# Copyright (c) 2019 Wladislaw Wagner (Vitasystems GmbH), Pablo Pazos (Hannover Medical School).
#
# This file is part of Project EHRbase
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Set desired loglevel: NONE, INFO, DEBUG, TRACE (most details)
export LOG_LEVEL=TRACE

# Comment ou any line to disable that suite from running

declare -A TEST_SUITES
TEST_SUITES[CONTRIBUTION]=I_EHR_CONTRIBUTION
#TEST_SUITES[COMPOSITION]=I_EHR_COMPOSITION
#TEST_SUITES[DIRECTORY]=I_EHR_DIRECTORY
#TEST_SUITES[EHR_SERVICE]=I_EHR_SERVICE
#TEST_SUITES[EHR_STATUS]=I_EHR_STATUS
#TEST_SUITES[aqlANDempty_db]=I_QUERY_SERVICE
#TEST_SUITES[aqlANDloaded_db]=I_QUERY_SERVICE

cd platform

for TEST_SUITE_TAG in "${!TEST_SUITES[@]}"
do
  TEST_SUITE_PATH=${TEST_SUITES[$TEST_SUITE_TAG]}
  robot -i "$TEST_SUITE_TAG" -e EHRBASE -e obsolete -e libtest \
      --outputdir results/test-suites/$TEST_SUITE_PATH \
      --noncritical not-ready \
      --flattenkeywords for \
      --flattenkeywords foritem \
      --flattenkeywords name:_resources.* \
      --loglevel $LOG_LEVEL \
      --name $TEST_SUITE_TAG \
      robot/$TEST_SUITE_PATH
done

# POST PROCESS & MERGE OUTPUTS

# Create Log/Report with ALL DETAILS
rebot --outputdir results \
      --name EHRbase \
      --exclude TODO -e future -e obsolete -e libtest \
      --removekeywords for \
      --removekeywords wuks \
      --loglevel TRACE \
      --noncritical not-ready \
      --timestampoutputs \
      --output EHRbase-output.xml \
      --log EHRbase-log.html \
      --report EHRbase-report.html \
      results/test-suites/*/*.xml