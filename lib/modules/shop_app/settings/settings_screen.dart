import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    prefixIcon: Icons.person,
                    onTap: () {},
                    controller: nameController,
                    label: 'Name',
                    keyboardType: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your name.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    prefixIcon: Icons.email,
                    onTap: () {},
                    controller: emailController,
                    label: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your email.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    prefixIcon: Icons.phone,
                    onTap: () {},
                    controller: phoneController,
                    label: 'Phone',
                    keyboardType: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your phone.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    onPressed: () {
                      signOut(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
