# Date Format 1.2.3
# (c) 2007-2009 Steven Levithan <stevenlevithan.com>
# MIT license
#
# Includes enhancements by Scott Trenda <scott.trenda.net>
# and Kris Kowal <cixar.com/~kris.kowal/>
#
# Modifications (c) 2011 Samuel Cochran <sj26@sj26.com>

token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g
timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g
timezoneClip = /[^-+\dA-Z]/g

String::repeat = (num) ->
  new Array(num + 1).join this

String::lpad = (padding, toLength) ->
  padding.repeat((toLength - @length) / padding.length).concat this

Date::format = (mask, utc = false) ->
  mask = String(masks[mask] || mask || masks["default"])

  self = this
  get = (a) -> self[(if utc then "getUTC" else "get") + a]()
  d = get "Date"
  D = get "Day"
  m = get "Month"
  y = get "FullYear"
  H = get "Hours"
  M = get "Minutes"
  s = get "Seconds"
  L = get "Milliseconds"
  o = if utc then 0 else @getTimezoneOffset()

  flags =
    d:    d
    dd:   String(d).lpad("0", 2)
    ddd:  @formatLocale.dayNames[D]
    dddd: @formatLocale.dayNames[D + 7]
    m:    m + 1
    mm:   String(m + 1).lpad("0", 2)
    mmm:  @formatLocale.monthNames[m]
    mmmm: @formatLocale.monthNames[m + 12]
    yy:   String(y).slice(2)
    yyyy: y
    h:    H % 12 || 12
    hh:   String(H % 12 || 12).lpad("0", 2)
    H:    H
    HH:   String(H).lpad("0", 2)
    M:    M
    MM:   String(M).lpad("0", 2)
    s:    s
    ss:   String(s).lpad("0", 2)
    l:    String(L, 3).lpad("0", 2)
    L:    String(if L > 99 then Math.round(L / 10) else L).lpad("0", 2)
    t:    if H < 12 then "a"  else "p"
    tt:   if H < 12 then "am" else "pm"
    T:    if H < 12 then "A"  else "P"
    TT:   if H < 12 then "AM" else "PM"
    Z:    if utc then "UTC" else (String(@).match(timezone) || [""]).pop().replace(timezoneClip, "")
    o:    (if o > 0 then "-" else "+") + String(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60).lpad("0", 4)
    S:    ["th", "st", "nd", "rd"][if d % 10 > 3 then 0 else (d % 100 - d % 10 != 10) * d % 10]

  result = mask.replace(token, (match) ->
    if match of flags then flags[match] else match.slice(1, match.length - 1)
  )
  result

# Some common format strings
masks =
  "default":      "ddd mmm dd yyyy HH:MM:ss",
  shortDate:      "m/d/yy",
  mediumDate:     "mmm d, yyyy",
  longDate:       "mmmm d, yyyy",
  fullDate:       "dddd, mmmm d, yyyy",
  shortTime:      "h:MM TT",
  mediumTime:     "h:MM:ss TT",
  longTime:       "h:MM:ss TT Z",
  isoDate:        "yyyy-mm-dd",
  isoTime:        "HH:MM:ss",
  isoDateTime:    "yyyy-mm-dd'T'HH:MM:ss",
  isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"

# Internationalization strings
Date::formatLocale =
  dayNames: [
    "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
    "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
  ]
  monthNames: [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
  ]
