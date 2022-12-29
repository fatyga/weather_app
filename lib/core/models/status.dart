enum StatusState { fetching, error, success }

class Status {
  StatusState state;
  String? comment;
  Function()? action;

  Status(this.state, this.comment, [this.action]);
}
