import 'package:frandr/state_management/redux/reducers/configurations_reducer.dart';
import 'package:frandr/state_management/redux/state/state.dart';

import 'actions.dart';

ReduxState appReducer(ReduxState state, action) {
  return action is Actions ? ReduxState(
    configurations: configurationsReducer(state.configurations, action),
  ) : state;
}
