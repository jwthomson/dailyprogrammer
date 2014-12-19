-- scraper for youtube
local json = require("json")
local http = require("ssl.https")
local api_key = "AIzaSyDO72B4_jgFVBVMGIgGoB_aikR4g3BUnzs"
local api_base_url = "https://www.googleapis.com/youtube/v3/"


local function table_to_string(t)
  local out = ""
  for k,v in pairs(t) do
    out = out .. k .. ": " .. (type(v) == "table" and ("{\n" .. table_to_string(v) .. "}")or (type(v) == "boolean" and (v and "t" or "f") or v)) .. "\n"
  end
  return out
end


local function get_videos_from_playlist(playlist_id)
  local request =
    api_base_url .. "playlistItems?" .. 
    "playlistId=" .. playlist_id ..
    "&key=" .. api_key ..
    "&part=contentDetails"
  local out = {}
  local npt = nil
  repeat
    local response = http.request(request .. (npt and "&pageToken=" .. npt or ""))
    local res = json.decode(response)
    for k,v in pairs(res.items) do
      table.insert(out, v.contentDetails.videoId)
    end
    npt = res.nextPageToken
  until npt == nil
  return out
end


local function get_video_stats(video_id)
  local request =
    api_base_url .. "videos?" ..
    "id=" .. video_id ..
    "&key=" .. api_key ..
    "&part=contentDetails"
  local response = http.request(request)
  print(response)
  -- return json.decode(response)
end


local function challenge()
  local playlist_id = "PLEMXAbCVnmY6RverunClc_DMLNDd3ASRp"
  local video_ids = get_videos_from_playlist(playlist_id)
  local video_stats = {}
  for i,v in ipairs(video_ids) do
    video_stats[v] = get_video_stats(v)
    if i == 3 then break end
  end

  print(table_to_string(video_stats))
end

challenge()