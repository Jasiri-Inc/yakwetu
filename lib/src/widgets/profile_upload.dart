import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yakwetu/src/config/themes/light_theme.dart';
import 'package:yakwetu/src/constants/constants.dart';
import 'package:yakwetu/src/modules/onboarding/profile_image_cubit.dart';

class ProfileUpload extends StatelessWidget {
  const ProfileUpload();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126.0,
      width: 126.0,
      child: Material(
        color: isLightTheme(context) ? Color(0xFFF2F2F2) : Color(0xFF211E1E),
        borderRadius: BorderRadius.circular(126.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(126.0),
          onTap: () async {
            await context.read<ProfileImageCubit>().getImage();
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: BlocBuilder<ProfileImageCubit, File?>(
                  builder: (context, state) {
                    return state == null
                        ? Icon(Icons.person_outline_rounded,
                            size: 126.0,
                            color: isLightTheme(context)
                                ? kIconLight
                                : Colors.black)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(126.0),
                            child: Image.file(state,
                                width: 126, height: 126, fit: BoxFit.fill),
                          );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.add_circle_rounded,
                  color: kPrimaryColor,
                  size: 38.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
