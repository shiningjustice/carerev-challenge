# CareRev Challenge: Events API 
## About
Developed by Phoebe Law
Heroku app: https://phoebe-law-events-app.herokuapp.com/events

## Endpoints 

### `GET '/events'`
Returns an array of objects with status `200`: 
```
[
  {
    "id": 1,
    "name": "name",
    "event_type": "event_type",
    "created_at": "2020-06-18T22:54:24.049Z",
    "updated_at": "2020-06-18T22:54:24.049Z",
    "other_params": {}
  },
  {
    "id": 2,
    "name": "name",
    "event_type": "event_type",
    "created_at": "2020-06-18T22:54:31.904Z",
    "updated_at": "2020-06-18T22:54:31.904Z",
    "other_params": {
      "at": "2020-06-12T00:00:01",
      "button_color": "red"
    }
  },
]
```

Can optionally take query params {date: "today"} to return number of events by
type in given day (see below). 


### `GET '/events?date=today'`
Returns an object and status `200`:
```
{
  "todays_stats": [
    {
      "click": 1
    },
    {
      "download": 1
    },
    {
      "view": 3
    }
  ]
}
```


### POST `/events`
Request body requires key `event`, with minimum children keys `name` and
`event_type`. Other fields can be optionally included. 
```
{
  "event": {
    "name": "test button", 
    "event_type": "click",
    "button_color": "blue"
  }
}
```

Returns a `201` status with an empty response body.

If `name` and `event_type` keys are ommitted, the server will return a `422`
status and an empty response body.


## Test The App

```
curl -X POST --header 'Content-Type: application/json' --data '{"event" : {"name" : "test button", "event_type" : "click", "at" : "2020-06-12T00:00:01", "button_color" : "red" }}' 'https://phoebe-law-events-app.herokuapp.com/events'
```
