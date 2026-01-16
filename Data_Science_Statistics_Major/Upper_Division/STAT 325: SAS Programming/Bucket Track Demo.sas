/* Example: SAS data cleaning + derived features + basic EDA */

/* Point SAS to a folder of datasets (replace with your own path) */
libname mydata "<PATH_TO_DATA_FOLDER>";

/* Bucket track duration (ms) into readable groups */
proc format;
  value durationfmt
    60000  - <180000 = "Short (1–3 min)"
    180000 - <300000 = "Medium (3–5 min)"
    300000 - high    = "Long (5+ min)";
run;

/* Clean genre + add duration group */
data mydata.spotify_prepped;
  set mydata.spotify_cleaned;

  length track_genre_clean $200;

  /* Keep only the first genre if multiple are separated by ';' */
  if index(track_genre, ";") > 0 then track_genre_clean = scan(track_genre, 1, ";");
  else track_genre_clean = track_genre;

  drop track_genre;
  rename track_genre_clean = track_genre;

  /* Create grouped duration label */
  duration_grouped = put(duration_ms, durationfmt.);
run;

/* Basic EDA */
proc contents data=mydata.spotify_prepped;
run;

proc print data=mydata.spotify_prepped(obs=10);
run;

proc freq data=mydata.spotify_prepped;
  tables track_genre duration_grouped;
run;

proc means data=mydata.spotify_prepped mean std min max;
  var popularity duration_ms tempo danceability;
run;

proc univariate data=mydata.spotify_prepped;
  var popularity;
  histogram;
run;
