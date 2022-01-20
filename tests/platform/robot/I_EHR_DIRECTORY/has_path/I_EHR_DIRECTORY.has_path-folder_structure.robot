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
Documentation    Alternative flow 2: has path on EHR with given folder structure
...
...     Preconditions:
...         An EHR with known ehr_id exists and has directory with an internal structure.
...
...     Flow:
...         1. Invoke the has path service for the ehr_id and the path $path from the data set
...         2. The result must be $result from the data set
...
...     Postconditions:
...         None
...
...     Data set
...         DS    | $path                                | $result |
...         ------+--------------------------------------+---------+
...         DS 01 | /                                    | true    |
...         DS 02 | /emergency                           | true    |
...         DS 03 | /emergency/episode_x                 | true    |
...         DS 04 | /emergency/episode_x/summary_compo_x | true    |
...         DS 05 | /emergency/episode_y                 | true    |
...         DS 06 | /emergency/episode_y/summary_compo_y | true    |
...         DS 07 | /hospitalization                     | true    |
...         DS 08 | /hospitalization/summary_compo_z     | true    |
...         DS 09 | /random_path                         | false   |
...         DS 10 | /foldername-w-special-chars          | true    |
Metadata        TOP_TEST_SUITE    DIRECTORY

Resource        ../../_resources/keywords/directory_keywords.robot
Resource        ../../_resources/keywords/composition_keywords.robot

Suite Setup    Establish Preconditions
# Test Setup  start openehr server
# Test Teardown  restore clean SUT state
#Suite Teardown  shutdown SUT

Force Tags    refactor


*** Test Cases ***
DS-01 - has path on EHR with given folder structure
    [Tags]
    get FOLDER in DIRECTORY at version (JSON)    /
    validate GET-@version response - 200 retrieved    root


DS-02 - has path on EHR with given folder structure
    [Tags]
    get FOLDER in DIRECTORY at version (JSON)    /emergency
    validate GET-@version response - 200 retrieved    emergency


DS-03 - has path on EHR with given folder structure
    [Tags]
    get FOLDER in DIRECTORY at version (JSON)    /emergency/episode_x
    validate GET-@version response - 200 retrieved    episode_x


DS-04 - has path on EHR with given folder structure

    get FOLDER in DIRECTORY at version (JSON)    /emergency/episode_x/summary_compo_x
    validate GET-@version response - 200 retrieved    summary_compo_x


DS-05 - has path on EHR with given folder structure

    get FOLDER in DIRECTORY at version (JSON)    /emergency/episode_y
    validate GET-@version response - 200 retrieved    episode_y


DS-06 - has path on EHR with given folder structure

    get FOLDER in DIRECTORY at version (JSON)    /emergency/episode_y/summary_compo_y
    validate GET-@version response - 200 retrieved    summary_compo_y


DS-07 - has path on EHR with given folder structure

    get FOLDER in DIRECTORY at version (JSON)    /hospitalization
    validate GET-@version response - 200 retrieved    hospitalization


DS-08 - has path on EHR with given folder structure

    get FOLDER in DIRECTORY at version (JSON)    /hospitalization/summary_compo_z
    validate GET-@version response - 200 retrieved    summary_compo_z


DS-09 - retrieving non-existing (random) path
    [Tags]
    generate random path
    get FOLDER in DIRECTORY at version (JSON)    ${path}
    validate GET-@version response - 404 unknown path


DS-10 - has path with special characters
    [Tags]
    get FOLDER in DIRECTORY at version (JSON)    /foldername-w-special-chars
    validate GET-@version response - 200 retrieved    foldername-w-special-chars




*** Keywords ****
Establish Preconditions
    create EHR
    create DIRECTORY (JSON)    subfolders_in_directory.json
