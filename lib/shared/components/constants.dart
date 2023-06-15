//POST
//UPDATE
//DELETE
//GET


//https://newsapi.org/
// v2/everything?
// q=tesla&from=2022-09-30&sortBy=publishedAt&apiKey=API_KEY

//https://newsapi.org/
//  ?
// country=us&category=business&apiKey=1fbd90b151a5420a995a59e6d0733eae



import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cashe_helper.dart';
import 'components.dart';

void signOut(context)
{
  CasheHelper.removeData(
    key:'token',).then((value) {
    if (value){
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}
void printFullText(String text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));
}
String token='';
String uId='';

