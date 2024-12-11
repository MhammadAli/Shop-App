import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/register/cubit/cubit.dart';
import 'package:untitled/modules/register/cubit/states.dart';

import '../../layout/shop_app/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../basics_app/login/cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener:(context,state){
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.data?.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then((value) {
                TOKEN = state.loginModel.data?.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                  message: state.loginModel.message.toString(),
                  state: ToastStates.error);
            }
          }
        } ,
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          onTap: () {},
                          controller: nameController,
                          label: 'User name',
                          keyboardType: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          onTap: () {},
                          controller: emailController,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            onSubmit: (value) {

                            },
                            onTap: () {},
                            isPassword: ShopRegisterCubit.get(context).isPassword,
                            controller: passwordController,
                            label: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                            },
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: ShopRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          onTap: () {},
                          controller: phoneController,
                          label: 'Phone',
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                          },
                          prefixIcon: Icons.phone,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              isUpperCase: true,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text ,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'Register'),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
