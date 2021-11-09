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
Metadata    Authors    *Wladislaw Wagner*, *Pablo Pazos*
Metadata    Created    2019.03.03

Documentation   C.4.a) Clear EHR queryable of existing EHR
Metadata        TOP_TEST_SUITE    EHR_STATUS

Resource        ../../_resources/keywords/ehr_keywords.robot

# Suite Setup  startup SUT
# Suite Teardown  shutdown SUT

Force Tags    refactor



*** Test Cases ***
Clear EHR queryable of existing EHR

    prepare new request session    JSON    Prefer=return=representation

    create new EHR

    update EHR: set ehr_status is_queryable    ${FALSE}

    check response of 'update EHR' (JSON)
