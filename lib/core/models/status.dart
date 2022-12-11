enum StatusState { fetching, error, success }

class Status {
  StatusState state;
  String? comment;

  Status(this.state, this.comment);
}
