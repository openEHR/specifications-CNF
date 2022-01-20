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



*** Settings ***
Metadata    Authors    *Wladislaw Wagner*, *Pablo Pazos*, *Pablo Pazos*
Metadata    Created    2019.03.03

Documentation   I_EHR_STATUS.set_ehr_modifiable-existing_ehr: Set EHR modifiable of an existing EHR
...
...             Preconditions:
...                 An EHR with known ehr_id should exist.
...
...             Postconditions:
...                 EHR_STATUS.is_queryable, for the EHR with known ehr_id, should be `true`
...
...             Flow:
...                 1. For the existing EHR, invoke the set EHR modifiable service
...                 2. The result should be positive and the corresponding
...                    EHR_STATUS.is_queryable should be `true`
Metadata        TOP_TEST_SUITE    EHR_STATUS

Resource        ../../_resources/keywords/ehr_keywords.robot

# Suite Setup  startup SUT
# Suite Teardown  shutdown SUT

Force Tags    refactor



*** Test Cases ***
Set EHR modifiable of an existing EHR

    prepare new request session    JSON    Prefer=return=representation

    create new EHR

    update EHR: set ehr-status modifiable    ${TRUE}

    check response of 'update EHR' (JSON)
