{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "97b5a8c8",
   "metadata": {
    "_cell_guid": "b1076dfc-b9ad-4769-8c92-a6c4dae69d19",
    "_uuid": "8f2839f25d086af736a60e9eeb907d3b93b6e0e5",
    "execution": {
     "iopub.execute_input": "2024-01-27T03:56:31.550087Z",
     "iopub.status.busy": "2024-01-27T03:56:31.547621Z",
     "iopub.status.idle": "2024-01-27T03:56:32.803795Z",
     "shell.execute_reply": "2024-01-27T03:56:32.801980Z"
    },
    "papermill": {
     "duration": 1.263899,
     "end_time": "2024-01-27T03:56:32.806462",
     "exception": false,
     "start_time": "2024-01-27T03:56:31.542563",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.4     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.3     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.2     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'fraud-detection'"
      ],
      "text/latex": [
       "'fraud-detection'"
      ],
      "text/markdown": [
       "'fraud-detection'"
      ],
      "text/plain": [
       "[1] \"fraud-detection\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Setting Up R enviornment \n",
    "\n",
    "library(tidyverse)\n",
    "library(dplyr)\n",
    "library(tidyr)\n",
    "library(readr)\n",
    "library(lubridate)\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory \n",
    "\n",
    "list.files(path = \"../input\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "123a41d3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-27T03:56:32.843632Z",
     "iopub.status.busy": "2024-01-27T03:56:32.813920Z",
     "iopub.status.idle": "2024-01-27T03:56:37.062299Z",
     "shell.execute_reply": "2024-01-27T03:56:37.060408Z"
    },
    "papermill": {
     "duration": 4.256434,
     "end_time": "2024-01-27T03:56:37.065771",
     "exception": false,
     "start_time": "2024-01-27T03:56:32.809337",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22mNew names:\n",
      "\u001b[36m•\u001b[39m `` -> `...1`\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m555719\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m23\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (10): merchant, category, first, last, gender, street, city, state, job...\n",
      "\u001b[32mdbl\u001b[39m  (11): ...1, cc_num, amt, zip, lat, long, city_pop, unix_time, merch_lat...\n",
      "\u001b[34mdttm\u001b[39m  (1): trans_date_trans_time\n",
      "\u001b[34mdate\u001b[39m  (1): dob\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    }
   ],
   "source": [
    "# load csv file\n",
    "credit_card_fraud_df = read_csv('/kaggle/input/fraud-detection/fraudTest.csv')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "1cc262fa",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-27T03:56:37.076313Z",
     "iopub.status.busy": "2024-01-27T03:56:37.074404Z",
     "iopub.status.idle": "2024-01-27T03:56:37.097087Z",
     "shell.execute_reply": "2024-01-27T03:56:37.094701Z"
    },
    "papermill": {
     "duration": 0.031075,
     "end_time": "2024-01-27T03:56:37.100143",
     "exception": false,
     "start_time": "2024-01-27T03:56:37.069068",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'...1'</li><li>'trans_date_trans_time'</li><li>'cc_num'</li><li>'merchant'</li><li>'category'</li><li>'amt'</li><li>'first'</li><li>'last'</li><li>'gender'</li><li>'street'</li><li>'city'</li><li>'state'</li><li>'zip'</li><li>'lat'</li><li>'long'</li><li>'city_pop'</li><li>'job'</li><li>'dob'</li><li>'trans_num'</li><li>'unix_time'</li><li>'merch_lat'</li><li>'merch_long'</li><li>'is_fraud'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item '...1'\n",
       "\\item 'trans\\_date\\_trans\\_time'\n",
       "\\item 'cc\\_num'\n",
       "\\item 'merchant'\n",
       "\\item 'category'\n",
       "\\item 'amt'\n",
       "\\item 'first'\n",
       "\\item 'last'\n",
       "\\item 'gender'\n",
       "\\item 'street'\n",
       "\\item 'city'\n",
       "\\item 'state'\n",
       "\\item 'zip'\n",
       "\\item 'lat'\n",
       "\\item 'long'\n",
       "\\item 'city\\_pop'\n",
       "\\item 'job'\n",
       "\\item 'dob'\n",
       "\\item 'trans\\_num'\n",
       "\\item 'unix\\_time'\n",
       "\\item 'merch\\_lat'\n",
       "\\item 'merch\\_long'\n",
       "\\item 'is\\_fraud'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. '...1'\n",
       "2. 'trans_date_trans_time'\n",
       "3. 'cc_num'\n",
       "4. 'merchant'\n",
       "5. 'category'\n",
       "6. 'amt'\n",
       "7. 'first'\n",
       "8. 'last'\n",
       "9. 'gender'\n",
       "10. 'street'\n",
       "11. 'city'\n",
       "12. 'state'\n",
       "13. 'zip'\n",
       "14. 'lat'\n",
       "15. 'long'\n",
       "16. 'city_pop'\n",
       "17. 'job'\n",
       "18. 'dob'\n",
       "19. 'trans_num'\n",
       "20. 'unix_time'\n",
       "21. 'merch_lat'\n",
       "22. 'merch_long'\n",
       "23. 'is_fraud'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"...1\"                  \"trans_date_trans_time\" \"cc_num\"               \n",
       " [4] \"merchant\"              \"category\"              \"amt\"                  \n",
       " [7] \"first\"                 \"last\"                  \"gender\"               \n",
       "[10] \"street\"                \"city\"                  \"state\"                \n",
       "[13] \"zip\"                   \"lat\"                   \"long\"                 \n",
       "[16] \"city_pop\"              \"job\"                   \"dob\"                  \n",
       "[19] \"trans_num\"             \"unix_time\"             \"merch_lat\"            \n",
       "[22] \"merch_long\"            \"is_fraud\"             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# exploring names of columns within the dataset\n",
    "\n",
    "names(credit_card_fraud_df)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "64431132",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-27T03:56:37.110616Z",
     "iopub.status.busy": "2024-01-27T03:56:37.108744Z",
     "iopub.status.idle": "2024-01-27T03:56:37.196588Z",
     "shell.execute_reply": "2024-01-27T03:56:37.193611Z"
    },
    "papermill": {
     "duration": 0.09646,
     "end_time": "2024-01-27T03:56:37.199859",
     "exception": false,
     "start_time": "2024-01-27T03:56:37.103399",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 23</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>...1</th><th scope=col>trans_date_trans_time</th><th scope=col>cc_num</th><th scope=col>merchant</th><th scope=col>category</th><th scope=col>amt</th><th scope=col>first</th><th scope=col>last</th><th scope=col>gender</th><th scope=col>street</th><th scope=col>⋯</th><th scope=col>lat</th><th scope=col>long</th><th scope=col>city_pop</th><th scope=col>job</th><th scope=col>dob</th><th scope=col>trans_num</th><th scope=col>unix_time</th><th scope=col>merch_lat</th><th scope=col>merch_long</th><th scope=col>is_fraud</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>0</td><td>2020-06-21 12:14:25</td><td>2.291164e+15</td><td>fraud_Kirlin and Sons               </td><td>personal_care </td><td> 2.86</td><td>Jeff    </td><td>Elliott </td><td>M</td><td>351 Darlene Green          </td><td>⋯</td><td>33.9659</td><td> -80.9355</td><td>333497</td><td>Mechanical engineer   </td><td>1968-03-19</td><td>2da90c7d74bd46a0caf3777415b3ebd3</td><td>1371816865</td><td>33.98639</td><td> -81.20071</td><td>0</td></tr>\n",
       "\t<tr><td>1</td><td>2020-06-21 12:14:33</td><td>3.573030e+15</td><td>fraud_Sporer-Keebler                </td><td>personal_care </td><td>29.84</td><td>Joanne  </td><td>Williams</td><td>F</td><td>3638 Marsh Union           </td><td>⋯</td><td>40.3207</td><td>-110.4360</td><td>   302</td><td>Sales professional, IT</td><td>1990-01-17</td><td>324cc204407e99f51b0d6ca0055005e7</td><td>1371816873</td><td>39.45050</td><td>-109.96043</td><td>0</td></tr>\n",
       "\t<tr><td>2</td><td>2020-06-21 12:14:53</td><td>3.598215e+15</td><td>fraud_Swaniawski, Nitzsche and Welch</td><td>health_fitness</td><td>41.28</td><td>Ashley  </td><td>Lopez   </td><td>F</td><td>9333 Valentine Point       </td><td>⋯</td><td>40.6729</td><td> -73.5365</td><td> 34496</td><td>Librarian, public     </td><td>1970-10-21</td><td>c81755dbbbea9d5c77f094348a7579be</td><td>1371816893</td><td>40.49581</td><td> -74.19611</td><td>0</td></tr>\n",
       "\t<tr><td>3</td><td>2020-06-21 12:15:15</td><td>3.591920e+15</td><td>fraud_Haley Group                   </td><td>misc_pos      </td><td>60.05</td><td>Brian   </td><td>Williams</td><td>M</td><td>32941 Krystal Mill Apt. 552</td><td>⋯</td><td>28.5697</td><td> -80.8191</td><td> 54767</td><td>Set designer          </td><td>1987-07-25</td><td>2159175b9efe66dc301f149d3d5abf8c</td><td>1371816915</td><td>28.81240</td><td> -80.88306</td><td>0</td></tr>\n",
       "\t<tr><td>4</td><td>2020-06-21 12:15:17</td><td>3.526826e+15</td><td>fraud_Johnston-Casper               </td><td>travel        </td><td> 3.19</td><td>Nathan  </td><td>Massey  </td><td>M</td><td>5783 Evan Roads Apt. 465   </td><td>⋯</td><td>44.2529</td><td> -85.0170</td><td>  1126</td><td>Furniture designer    </td><td>1955-07-06</td><td>57ff021bd3f328f8738bb535c302a31b</td><td>1371816917</td><td>44.95915</td><td> -85.88473</td><td>0</td></tr>\n",
       "\t<tr><td>5</td><td>2020-06-21 12:15:37</td><td>3.040768e+13</td><td>fraud_Daugherty LLC                 </td><td>kids_pets     </td><td>19.55</td><td>Danielle</td><td>Evans   </td><td>F</td><td>76752 David Lodge Apt. 064 </td><td>⋯</td><td>42.1939</td><td> -76.7361</td><td>   520</td><td>Psychotherapist       </td><td>1991-10-13</td><td>798db04aaceb4febd084f1a7c404da93</td><td>1371816937</td><td>41.74716</td><td> -77.58420</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 23\n",
       "\\begin{tabular}{lllllllllllllllllllll}\n",
       " ...1 & trans\\_date\\_trans\\_time & cc\\_num & merchant & category & amt & first & last & gender & street & ⋯ & lat & long & city\\_pop & job & dob & trans\\_num & unix\\_time & merch\\_lat & merch\\_long & is\\_fraud\\\\\n",
       " <dbl> & <dttm> & <dbl> & <chr> & <chr> & <dbl> & <chr> & <chr> & <chr> & <chr> & ⋯ & <dbl> & <dbl> & <dbl> & <chr> & <date> & <chr> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 0 & 2020-06-21 12:14:25 & 2.291164e+15 & fraud\\_Kirlin and Sons                & personal\\_care  &  2.86 & Jeff     & Elliott  & M & 351 Darlene Green           & ⋯ & 33.9659 &  -80.9355 & 333497 & Mechanical engineer    & 1968-03-19 & 2da90c7d74bd46a0caf3777415b3ebd3 & 1371816865 & 33.98639 &  -81.20071 & 0\\\\\n",
       "\t 1 & 2020-06-21 12:14:33 & 3.573030e+15 & fraud\\_Sporer-Keebler                 & personal\\_care  & 29.84 & Joanne   & Williams & F & 3638 Marsh Union            & ⋯ & 40.3207 & -110.4360 &    302 & Sales professional, IT & 1990-01-17 & 324cc204407e99f51b0d6ca0055005e7 & 1371816873 & 39.45050 & -109.96043 & 0\\\\\n",
       "\t 2 & 2020-06-21 12:14:53 & 3.598215e+15 & fraud\\_Swaniawski, Nitzsche and Welch & health\\_fitness & 41.28 & Ashley   & Lopez    & F & 9333 Valentine Point        & ⋯ & 40.6729 &  -73.5365 &  34496 & Librarian, public      & 1970-10-21 & c81755dbbbea9d5c77f094348a7579be & 1371816893 & 40.49581 &  -74.19611 & 0\\\\\n",
       "\t 3 & 2020-06-21 12:15:15 & 3.591920e+15 & fraud\\_Haley Group                    & misc\\_pos       & 60.05 & Brian    & Williams & M & 32941 Krystal Mill Apt. 552 & ⋯ & 28.5697 &  -80.8191 &  54767 & Set designer           & 1987-07-25 & 2159175b9efe66dc301f149d3d5abf8c & 1371816915 & 28.81240 &  -80.88306 & 0\\\\\n",
       "\t 4 & 2020-06-21 12:15:17 & 3.526826e+15 & fraud\\_Johnston-Casper                & travel         &  3.19 & Nathan   & Massey   & M & 5783 Evan Roads Apt. 465    & ⋯ & 44.2529 &  -85.0170 &   1126 & Furniture designer     & 1955-07-06 & 57ff021bd3f328f8738bb535c302a31b & 1371816917 & 44.95915 &  -85.88473 & 0\\\\\n",
       "\t 5 & 2020-06-21 12:15:37 & 3.040768e+13 & fraud\\_Daugherty LLC                  & kids\\_pets      & 19.55 & Danielle & Evans    & F & 76752 David Lodge Apt. 064  & ⋯ & 42.1939 &  -76.7361 &    520 & Psychotherapist        & 1991-10-13 & 798db04aaceb4febd084f1a7c404da93 & 1371816937 & 41.74716 &  -77.58420 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 23\n",
       "\n",
       "| ...1 &lt;dbl&gt; | trans_date_trans_time &lt;dttm&gt; | cc_num &lt;dbl&gt; | merchant &lt;chr&gt; | category &lt;chr&gt; | amt &lt;dbl&gt; | first &lt;chr&gt; | last &lt;chr&gt; | gender &lt;chr&gt; | street &lt;chr&gt; | ⋯ ⋯ | lat &lt;dbl&gt; | long &lt;dbl&gt; | city_pop &lt;dbl&gt; | job &lt;chr&gt; | dob &lt;date&gt; | trans_num &lt;chr&gt; | unix_time &lt;dbl&gt; | merch_lat &lt;dbl&gt; | merch_long &lt;dbl&gt; | is_fraud &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 0 | 2020-06-21 12:14:25 | 2.291164e+15 | fraud_Kirlin and Sons                | personal_care  |  2.86 | Jeff     | Elliott  | M | 351 Darlene Green           | ⋯ | 33.9659 |  -80.9355 | 333497 | Mechanical engineer    | 1968-03-19 | 2da90c7d74bd46a0caf3777415b3ebd3 | 1371816865 | 33.98639 |  -81.20071 | 0 |\n",
       "| 1 | 2020-06-21 12:14:33 | 3.573030e+15 | fraud_Sporer-Keebler                 | personal_care  | 29.84 | Joanne   | Williams | F | 3638 Marsh Union            | ⋯ | 40.3207 | -110.4360 |    302 | Sales professional, IT | 1990-01-17 | 324cc204407e99f51b0d6ca0055005e7 | 1371816873 | 39.45050 | -109.96043 | 0 |\n",
       "| 2 | 2020-06-21 12:14:53 | 3.598215e+15 | fraud_Swaniawski, Nitzsche and Welch | health_fitness | 41.28 | Ashley   | Lopez    | F | 9333 Valentine Point        | ⋯ | 40.6729 |  -73.5365 |  34496 | Librarian, public      | 1970-10-21 | c81755dbbbea9d5c77f094348a7579be | 1371816893 | 40.49581 |  -74.19611 | 0 |\n",
       "| 3 | 2020-06-21 12:15:15 | 3.591920e+15 | fraud_Haley Group                    | misc_pos       | 60.05 | Brian    | Williams | M | 32941 Krystal Mill Apt. 552 | ⋯ | 28.5697 |  -80.8191 |  54767 | Set designer           | 1987-07-25 | 2159175b9efe66dc301f149d3d5abf8c | 1371816915 | 28.81240 |  -80.88306 | 0 |\n",
       "| 4 | 2020-06-21 12:15:17 | 3.526826e+15 | fraud_Johnston-Casper                | travel         |  3.19 | Nathan   | Massey   | M | 5783 Evan Roads Apt. 465    | ⋯ | 44.2529 |  -85.0170 |   1126 | Furniture designer     | 1955-07-06 | 57ff021bd3f328f8738bb535c302a31b | 1371816917 | 44.95915 |  -85.88473 | 0 |\n",
       "| 5 | 2020-06-21 12:15:37 | 3.040768e+13 | fraud_Daugherty LLC                  | kids_pets      | 19.55 | Danielle | Evans    | F | 76752 David Lodge Apt. 064  | ⋯ | 42.1939 |  -76.7361 |    520 | Psychotherapist        | 1991-10-13 | 798db04aaceb4febd084f1a7c404da93 | 1371816937 | 41.74716 |  -77.58420 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  ...1 trans_date_trans_time cc_num       merchant                            \n",
       "1 0    2020-06-21 12:14:25   2.291164e+15 fraud_Kirlin and Sons               \n",
       "2 1    2020-06-21 12:14:33   3.573030e+15 fraud_Sporer-Keebler                \n",
       "3 2    2020-06-21 12:14:53   3.598215e+15 fraud_Swaniawski, Nitzsche and Welch\n",
       "4 3    2020-06-21 12:15:15   3.591920e+15 fraud_Haley Group                   \n",
       "5 4    2020-06-21 12:15:17   3.526826e+15 fraud_Johnston-Casper               \n",
       "6 5    2020-06-21 12:15:37   3.040768e+13 fraud_Daugherty LLC                 \n",
       "  category       amt   first    last     gender street                      ⋯\n",
       "1 personal_care   2.86 Jeff     Elliott  M      351 Darlene Green           ⋯\n",
       "2 personal_care  29.84 Joanne   Williams F      3638 Marsh Union            ⋯\n",
       "3 health_fitness 41.28 Ashley   Lopez    F      9333 Valentine Point        ⋯\n",
       "4 misc_pos       60.05 Brian    Williams M      32941 Krystal Mill Apt. 552 ⋯\n",
       "5 travel          3.19 Nathan   Massey   M      5783 Evan Roads Apt. 465    ⋯\n",
       "6 kids_pets      19.55 Danielle Evans    F      76752 David Lodge Apt. 064  ⋯\n",
       "  lat     long      city_pop job                    dob       \n",
       "1 33.9659  -80.9355 333497   Mechanical engineer    1968-03-19\n",
       "2 40.3207 -110.4360    302   Sales professional, IT 1990-01-17\n",
       "3 40.6729  -73.5365  34496   Librarian, public      1970-10-21\n",
       "4 28.5697  -80.8191  54767   Set designer           1987-07-25\n",
       "5 44.2529  -85.0170   1126   Furniture designer     1955-07-06\n",
       "6 42.1939  -76.7361    520   Psychotherapist        1991-10-13\n",
       "  trans_num                        unix_time  merch_lat merch_long is_fraud\n",
       "1 2da90c7d74bd46a0caf3777415b3ebd3 1371816865 33.98639   -81.20071 0       \n",
       "2 324cc204407e99f51b0d6ca0055005e7 1371816873 39.45050  -109.96043 0       \n",
       "3 c81755dbbbea9d5c77f094348a7579be 1371816893 40.49581   -74.19611 0       \n",
       "4 2159175b9efe66dc301f149d3d5abf8c 1371816915 28.81240   -80.88306 0       \n",
       "5 57ff021bd3f328f8738bb535c302a31b 1371816917 44.95915   -85.88473 0       \n",
       "6 798db04aaceb4febd084f1a7c404da93 1371816937 41.74716   -77.58420 0       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# gauging how the data is organized by printing the first five rows within the dataset\n",
    "\n",
    "head(credit_card_fraud_df)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "e40b5ff5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-27T03:56:37.211527Z",
     "iopub.status.busy": "2024-01-27T03:56:37.209500Z",
     "iopub.status.idle": "2024-01-27T03:56:37.233091Z",
     "shell.execute_reply": "2024-01-27T03:56:37.230488Z"
    },
    "papermill": {
     "duration": 0.033251,
     "end_time": "2024-01-27T03:56:37.236675",
     "exception": false,
     "start_time": "2024-01-27T03:56:37.203424",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'spec_tbl_df'</li><li>'tbl_df'</li><li>'tbl'</li><li>'data.frame'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'spec\\_tbl\\_df'\n",
       "\\item 'tbl\\_df'\n",
       "\\item 'tbl'\n",
       "\\item 'data.frame'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'spec_tbl_df'\n",
       "2. 'tbl_df'\n",
       "3. 'tbl'\n",
       "4. 'data.frame'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"spec_tbl_df\" \"tbl_df\"      \"tbl\"         \"data.frame\" "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "class(credit_card_fraud_df)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "c5d023f7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-27T03:56:37.248945Z",
     "iopub.status.busy": "2024-01-27T03:56:37.246883Z",
     "iopub.status.idle": "2024-01-27T03:56:37.322573Z",
     "shell.execute_reply": "2024-01-27T03:56:37.319710Z"
    },
    "papermill": {
     "duration": 0.085433,
     "end_time": "2024-01-27T03:56:37.326004",
     "exception": false,
     "start_time": "2024-01-27T03:56:37.240571",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "spc_tbl_ [555,719 × 23] (S3: spec_tbl_df/tbl_df/tbl/data.frame)\n",
      " $ ...1                 : num [1:555719] 0 1 2 3 4 5 6 7 8 9 ...\n",
      " $ trans_date_trans_time: POSIXct[1:555719], format: \"2020-06-21 12:14:25\" \"2020-06-21 12:14:33\" ...\n",
      " $ cc_num               : num [1:555719] 2.29e+15 3.57e+15 3.60e+15 3.59e+15 3.53e+15 ...\n",
      " $ merchant             : chr [1:555719] \"fraud_Kirlin and Sons\" \"fraud_Sporer-Keebler\" \"fraud_Swaniawski, Nitzsche and Welch\" \"fraud_Haley Group\" ...\n",
      " $ category             : chr [1:555719] \"personal_care\" \"personal_care\" \"health_fitness\" \"misc_pos\" ...\n",
      " $ amt                  : num [1:555719] 2.86 29.84 41.28 60.05 3.19 ...\n",
      " $ first                : chr [1:555719] \"Jeff\" \"Joanne\" \"Ashley\" \"Brian\" ...\n",
      " $ last                 : chr [1:555719] \"Elliott\" \"Williams\" \"Lopez\" \"Williams\" ...\n",
      " $ gender               : chr [1:555719] \"M\" \"F\" \"F\" \"M\" ...\n",
      " $ street               : chr [1:555719] \"351 Darlene Green\" \"3638 Marsh Union\" \"9333 Valentine Point\" \"32941 Krystal Mill Apt. 552\" ...\n",
      " $ city                 : chr [1:555719] \"Columbia\" \"Altonah\" \"Bellmore\" \"Titusville\" ...\n",
      " $ state                : chr [1:555719] \"SC\" \"UT\" \"NY\" \"FL\" ...\n",
      " $ zip                  : num [1:555719] 29209 84002 11710 32780 49632 ...\n",
      " $ lat                  : num [1:555719] 34 40.3 40.7 28.6 44.3 ...\n",
      " $ long                 : num [1:555719] -80.9 -110.4 -73.5 -80.8 -85 ...\n",
      " $ city_pop             : num [1:555719] 333497 302 34496 54767 1126 ...\n",
      " $ job                  : chr [1:555719] \"Mechanical engineer\" \"Sales professional, IT\" \"Librarian, public\" \"Set designer\" ...\n",
      " $ dob                  : Date[1:555719], format: \"1968-03-19\" \"1990-01-17\" ...\n",
      " $ trans_num            : chr [1:555719] \"2da90c7d74bd46a0caf3777415b3ebd3\" \"324cc204407e99f51b0d6ca0055005e7\" \"c81755dbbbea9d5c77f094348a7579be\" \"2159175b9efe66dc301f149d3d5abf8c\" ...\n",
      " $ unix_time            : num [1:555719] 1.37e+09 1.37e+09 1.37e+09 1.37e+09 1.37e+09 ...\n",
      " $ merch_lat            : num [1:555719] 34 39.5 40.5 28.8 45 ...\n",
      " $ merch_long           : num [1:555719] -81.2 -110 -74.2 -80.9 -85.9 ...\n",
      " $ is_fraud             : num [1:555719] 0 0 0 0 0 0 0 0 0 0 ...\n",
      " - attr(*, \"spec\")=\n",
      "  .. cols(\n",
      "  ..   ...1 = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   trans_date_trans_time = \u001b[34mcol_datetime(format = \"\")\u001b[39m,\n",
      "  ..   cc_num = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   merchant = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   category = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   amt = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   first = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   last = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   gender = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   street = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   city = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   state = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   zip = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   lat = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   long = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   city_pop = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   job = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   dob = \u001b[34mcol_date(format = \"\")\u001b[39m,\n",
      "  ..   trans_num = \u001b[31mcol_character()\u001b[39m,\n",
      "  ..   unix_time = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   merch_lat = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   merch_long = \u001b[32mcol_double()\u001b[39m,\n",
      "  ..   is_fraud = \u001b[32mcol_double()\u001b[39m\n",
      "  .. )\n",
      " - attr(*, \"problems\")=<externalptr> \n"
     ]
    }
   ],
   "source": [
    "str(credit_card_fraud_df)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "d860b8ca",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2024-01-27T03:56:37.338489Z",
     "iopub.status.busy": "2024-01-27T03:56:37.336473Z",
     "iopub.status.idle": "2024-01-27T03:56:38.426562Z",
     "shell.execute_reply": "2024-01-27T03:56:38.423880Z"
    },
    "papermill": {
     "duration": 1.099651,
     "end_time": "2024-01-27T03:56:38.429762",
     "exception": false,
     "start_time": "2024-01-27T03:56:37.330111",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "      ...1        trans_date_trans_time             cc_num         \n",
       " Min.   :     0   Min.   :2020-06-21 12:14:25   Min.   :6.042e+10  \n",
       " 1st Qu.:138930   1st Qu.:2020-08-09 06:10:27   1st Qu.:1.800e+14  \n",
       " Median :277859   Median :2020-10-03 00:59:48   Median :3.521e+15  \n",
       " Mean   :277859   Mean   :2020-10-02 01:54:25   Mean   :4.178e+17  \n",
       " 3rd Qu.:416788   3rd Qu.:2020-12-01 03:03:04   3rd Qu.:4.635e+15  \n",
       " Max.   :555718   Max.   :2020-12-31 23:59:34   Max.   :4.992e+18  \n",
       "   merchant           category              amt              first          \n",
       " Length:555719      Length:555719      Min.   :    1.00   Length:555719     \n",
       " Class :character   Class :character   1st Qu.:    9.63   Class :character  \n",
       " Mode  :character   Mode  :character   Median :   47.29   Mode  :character  \n",
       "                                       Mean   :   69.39                     \n",
       "                                       3rd Qu.:   83.01                     \n",
       "                                       Max.   :22768.11                     \n",
       "     last              gender             street              city          \n",
       " Length:555719      Length:555719      Length:555719      Length:555719     \n",
       " Class :character   Class :character   Class :character   Class :character  \n",
       " Mode  :character   Mode  :character   Mode  :character   Mode  :character  \n",
       "                                                                            \n",
       "                                                                            \n",
       "                                                                            \n",
       "    state                zip             lat             long        \n",
       " Length:555719      Min.   : 1257   Min.   :20.03   Min.   :-165.67  \n",
       " Class :character   1st Qu.:26292   1st Qu.:34.67   1st Qu.: -96.80  \n",
       " Mode  :character   Median :48174   Median :39.37   Median : -87.48  \n",
       "                    Mean   :48843   Mean   :38.54   Mean   : -90.23  \n",
       "                    3rd Qu.:72011   3rd Qu.:41.89   3rd Qu.: -80.18  \n",
       "                    Max.   :99921   Max.   :65.69   Max.   : -67.95  \n",
       "    city_pop           job                 dob              trans_num        \n",
       " Min.   :     23   Length:555719      Min.   :1924-10-30   Length:555719     \n",
       " 1st Qu.:    741   Class :character   1st Qu.:1962-09-27   Class :character  \n",
       " Median :   2408   Mode  :character   Median :1975-11-30   Mode  :character  \n",
       " Mean   :  88222                      Mean   :1973-11-11                     \n",
       " 3rd Qu.:  19685                      3rd Qu.:1987-04-23                     \n",
       " Max.   :2906700                      Max.   :2005-01-29                     \n",
       "   unix_time           merch_lat       merch_long         is_fraud      \n",
       " Min.   :1.372e+09   Min.   :19.03   Min.   :-166.67   Min.   :0.00000  \n",
       " 1st Qu.:1.376e+09   1st Qu.:34.76   1st Qu.: -96.91   1st Qu.:0.00000  \n",
       " Median :1.381e+09   Median :39.38   Median : -87.45   Median :0.00000  \n",
       " Mean   :1.381e+09   Mean   :38.54   Mean   : -90.23   Mean   :0.00386  \n",
       " 3rd Qu.:1.386e+09   3rd Qu.:41.95   3rd Qu.: -80.26   3rd Qu.:0.00000  \n",
       " Max.   :1.389e+09   Max.   :66.68   Max.   : -66.95   Max.   :1.00000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(credit_card_fraud_df)"
   ]
  }
 ],
 "metadata": {
  "kaggle": {
   "accelerator": "none",
   "dataSources": [
    {
     "datasetId": 817870,
     "sourceId": 1399887,
     "sourceType": "datasetVersion"
    }
   ],
   "dockerImageVersionId": 30618,
   "isGpuEnabled": false,
   "isInternetEnabled": false,
   "language": "r",
   "sourceType": "notebook"
  },
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 10.476012,
   "end_time": "2024-01-27T03:56:38.556317",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2024-01-27T03:56:28.080305",
   "version": "2.5.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
