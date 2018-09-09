# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
  send_planes_in_air =(planes, res) ->
    plane_loc_url = "https://public-api.adsbexchange.com/VirtualRadar/AircraftList.json"
    robot.http(plane_loc_url).get() (err, response, body) ->
      plane_data = JSON.parse(body)
      found_plane = false
      for plane in plane_data.acList
        if plane.Reg in planes
          found_plane = true
          res.send(plane.Reg + " is underway\nLatitude: " + plane.Lat + "\nLongitude: " + plane.Long + "\nModel: " + plane.Mdl + "\nFlight Info: https://flightaware.com/live/flight/" + plane.Reg + "\n\n")
      if (found_plane == false)
        res.send("No planes in the air")

  robot.hear /zeplane/gim, (res) ->
    send_planes_in_air(["N286MP","N551CP","N553CP","N556CP","N557CP","N558CP","N113HP","N12HP","N17HP","N18HP","N19HP","N311HP","N514HP","N6HP","N717HP","N71HP","N73HP"], res)
