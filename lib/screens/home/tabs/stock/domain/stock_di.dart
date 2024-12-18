import 'package:trade_mate/screens/home/tabs/stock/data/data/stock_fire_base_functions.dart';
import 'package:trade_mate/screens/home/tabs/stock/data/repo_impl/stock_data_source_impl.dart';
import 'package:trade_mate/screens/home/tabs/stock/data/repo_impl/stock_repo_impl.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/repo/stock_data_source.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/repo/stock_repository.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/use_case/stock_use_cases.dart';

StockUseCases injectStockUseCases(){
  return StockUseCases(stockRepository:injectStockRepository() );
}
StockRepository  injectStockRepository(){
  return StockRepoImpl(stockDataSource:injectStockDataSource() );
}
StockDataSource injectStockDataSource(){
  return StockDataSourceImpl(stockFireBaseFunctions: injectStockFireBaseFunctions());
}
StockFireBaseFunctions injectStockFireBaseFunctions(){
  return StockFireBaseFunctions();
}