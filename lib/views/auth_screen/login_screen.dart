import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/controllers/auth_controller.dart';
import 'package:admin_luanvan/views/widget/loading_indicator.dart';
import '/views/home_screen/home.dart';
import '/views/widget/button.dart';
import '/views/widget/text_style.dart';
import 'package:get/get.dart';

class LoginSreen extends StatelessWidget {
  const LoginSreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                icLogo,
                width: 70,
                height: 70,
                ).box.border(
                  color: white
                ).rounded.padding(const EdgeInsets.all(8.0)).make(),
                10.heightBox,
                boldText(text: appname, size: 20.0),
                ],
              ),
              60.heightBox,
              Obx(() =>Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        fillColor: textfieldGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.email, color: purpleColor),
                        border: InputBorder.none,
                        hintText: emailHint,
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        fillColor: textfieldGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.lock, color: purpleColor),
                        border: InputBorder.none,
                        hintText: passwordHint,
                      ),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword, color: purpleColor))),
                    20.heightBox,
                      SizedBox(
                        width: context.screenWidth -100,
                        child: controller.isloading.value ? loadingIndicator() : ourButton(
                          title: login,
                          onPress: () async {
                            controller.isloading(true);
                            await controller.loginMethod(context: context).then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: "Logged in");
                                controller.isloading(false);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          },
                        ),
                      ),
                      5.heightBox,
                  ],
                ).box.white.rounded.outerShadowMd.padding(const EdgeInsets.all(8)).make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem,color: lightGrey)),
              const Spacer(),
              Center(child: boldText(text: credit)),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}