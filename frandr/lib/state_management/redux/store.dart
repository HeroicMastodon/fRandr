import 'package:frandr/state_management/redux/reducers/app_reducer.dart';
import 'package:frandr/state_management/redux/state/state.dart';
import 'package:redux/redux.dart';

Store<ReduxState> createReduxStore() => Store<ReduxState>(
  appReducer,
  initialState: const ReduxState()
);

