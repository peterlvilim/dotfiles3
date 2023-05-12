import { css } from "uebersicht";

const base03 = "#002b36";
const white = "#eee8d5";
const base01 = "#586e75";
const base3 = "#fdf6e3";
const green = "#859900";

const workspaces = css({
  display: "flex",
  justifyContent: "flex-start",
  paddingLeft: "10px",
});

const main = css({
  display: "flex",
  alignItems: "center",
  flexDirection: "row",
  height: "38px",
  width: "2056px",
  backgroundColor: base03,
  fontFamily: "Verdana",
  fontSize: "10px",
});

const workspaceEnabled = css({
  backgroundColor: green,
  color: white,
  borderColor: white,
});

const workspaceDisabled = css({
  backgroundColor: base03,
  color: base01,
  borderColor: base01,
});

const workspace = css({
  height: "12px",
  margin: "5px",
  padding: "3px",
  borderWidth: "1px",
  borderStyle: "solid",
});

const timeOuter = css({
  display: "flex",
  alignItems: "center",
  flexDirection: "column",
  padding: "5px",
});

const dateGroupOuter = css({
  flexGrow: "1",
  paddingRight: "10px",
  display: "flex",
  justifyContent: "flex-end",
  flexDirection: "row",
  color: base01,
});
const dateGroupInner = css({
  display: "flex",
  flexDirection: "row",
  alignItems: "center",
});

// print timestamps to debug
export const refreshFrequency = 50;

export const command = `./top-bar/target/debug/status`;

// todo handle errors?
export const updateState = (command_output, previousState) => {
  const new_state = JSON.parse(command_output.output);
  return new_state;
};

function Workspace({ index, label, enabled }) {
  return (
    <div
      key={index}
      className={`${workspace} ${
        enabled ? workspaceEnabled : workspaceDisabled
      }`}
    >
      {index} - {label}
    </div>
  );
}

function DateContainer({ weekday, month, day, times }) {
  return (
    <div className={dateGroupInner}>
      <div>
        {weekday} {month.toString().padStart(2, "0")}/
        {day.toString().padStart(2, "0")}
      </div>
      {times.map((time) => (
        <TimeDisplay
          label={time.label}
          hour={time.hour.toString().padStart(2, "0")}
          minute={time.minute.toString().padStart(2, "0")}
        />
      ))}
    </div>
  );
}

function TimeDisplay({ label, hour, minute }) {
  return (
    <div key={label} className={timeOuter}>
      <div>{label}</div>
      <div>
        {hour}:{minute}
      </div>
    </div>
  );
}

export const render = (new_state, error) => {
  //return <div />;
  if (new_state.spaces === undefined) {
    return <div />;
  }

  return (
    <div className={main}>
      <div className={workspaces}>
        {new_state.spaces.map((space) => (
          <Workspace
            key={space.index}
            index={space.index}
            label={space.label}
            enabled={space.enabled}
          />
        ))}
      </div>
      <div className={dateGroupOuter}>
        {new_state.date_group_1.times.length > 0 && (
          <DateContainer
            weekday={new_state.date_group_1.weekday}
            month={new_state.date_group_1.month}
            day={new_state.date_group_1.day}
            times={new_state.date_group_1.times}
          />
        )}
        <DateContainer
          weekday={new_state.date_group_2.weekday}
          month={new_state.date_group_2.month}
          day={new_state.date_group_2.day}
          times={new_state.date_group_2.times}
        />
      </div>
    </div>
  );
};

// todo
// move bar grouping to right
// make use of classes for css
// fix not selected color
// fix selected color
// fix font
//

// todo
// workspaces with numbers by them
// battery percent
// network state?
// clocks for various time zones
//
// other:
// unread notifications for gmail, slack, etc
// next calendar event?
