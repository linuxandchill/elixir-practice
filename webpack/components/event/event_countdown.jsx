import React, { Component } from 'react';
import moment from 'moment';

export default class EventCountdown extends Component {
  constructor (props) {
    super(props)
  }

  componentDidMount () {
    let scheduled_at = this.props.scheduled_at

    let now = new Date()
    let startingTime = moment(scheduled_at).unix()

    let secondsRemaining = startingTime - (now.getTime() / 1000)
    var clock = $('#countdown').FlipClock(secondsRemaining, {
      clockFace: 'DailyCounter',
      countdown: true
    })
  }

  render () {
    return (
      <div>
        <div className="countdown-show" id="countdown">
        <p>Event skedged for: {moment(this.props.scheduled_at).format("dddd, MMMM Do YYYY, h:mm:ss a")}</p>
      </div>
      </div>

    )
  }
}
