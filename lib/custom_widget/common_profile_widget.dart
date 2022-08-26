import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moneytree/utils/constants/color_constant.dart';
import 'package:moneytree/utils/constants/icon_constant.dart';
import 'package:moneytree/utils/size_utils.dart';

class CommonProfileWidget extends StatefulWidget {
  final Widget scrollItems;
  final Function editProfileInfoTap;
  final Function onEditImageTap;
  final File file;
  final String name;
  final String imageUrl;
  final bool backEnable;

  const CommonProfileWidget(
      {Key key,
      this.scrollItems,
      this.editProfileInfoTap,
      this.onEditImageTap,
      this.file,
      this.name,
      this.imageUrl,
      this.backEnable = false})
      : super(key: key);

  @override
  _CommonProfileWidgetState createState() => _CommonProfileWidgetState();
}

class _CommonProfileWidgetState extends State<CommonProfileWidget> {
  final double profilePicSize = 110;
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Stack(
      children: <Widget>[
        Container(
          width: SizeUtils.screenWidth,
        ),
        widget.editProfileInfoTap == null
            ? Container()
            : Positioned(
                right: 10,
                top: 20,
                child: InkWell(
                  onTap: widget.editProfileInfoTap,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.edit,
                        color: ColorConstants.APP_THEME_COLOR, size: 20),
                  ),
                )),
        widget.backEnable ? Positioned(
            left: 18,
            top: 25,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back,
                    color: ColorConstants.WHITE, size: 20))) : Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeUtils.get(50)),
            Expanded(
              child: profileAndITemStack(),
            ),
          ],
        )
      ],
    );
  }

  Row backButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(SizeUtils.get(10)),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              size: SizeUtils.get(16),
            ),
          ),
        ),
        Flexible(child: Container()),
        widget.editProfileInfoTap != null
            ? Padding(
                padding: EdgeInsets.all(SizeUtils.get(10)),
                child: InkWell(
                  onTap: widget.editProfileInfoTap,
                  child: Icon(
                    Icons.edit,
                    size: SizeUtils.get(18),
                  ),
                ),
              )
            : Container(),
        SizedBox(
          width: SizeUtils.get(5),
        )
      ],
    );
  }

  Widget profileAndITemStack() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: profilePicSize / 2.0),
          child: Container(
            width: SizeUtils.screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: menuColumn(),
          ),
        ),
        profilePictureContainer(),
      ],
    );
  }

  /*
  * Profile picture stack with edit icon if onEditTap is not null then it will display
  * */
  Stack profilePictureContainer() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              bottom: SizeUtils.get(4), right: SizeUtils.get(4)),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(22)),
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              width: profilePicSize,
              height: profilePicSize,
              child: getImage(),
            ),
          ),
        ),
        widget.onEditImageTap != null
            ? InkWell(
                onTap: widget.onEditImageTap,
                child: Container(
                  padding: EdgeInsets.all(SizeUtils.get(6)),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.APP_THEME_COLOR,
                      border: Border.all(width: 3, color: Colors.white)),
                  child: Icon(
                    Icons.edit,
                    size: SizeUtils.get(12),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }

  /*
  * adding scroll item widgets
  * */
  Column menuColumn() {
    return Column(
      children: <Widget>[
        SizedBox(height: SizeUtils.get(75)),
        widget.name != null
            ? Text(
                widget.name ?? '',
                textAlign: TextAlign.center,
                style: themeData.textTheme.headline6
                    .copyWith(color: ColorConstants.APP_THEME_COLOR),
              )
            : SizedBox(),
        SizedBox(height: SizeUtils.get(40)),
        Expanded(
          child: widget.scrollItems,
        ),
      ],
    );
  }

  /*
  * Return image as per, file and url availability
  * */
  Widget getImage() {
    var image;
    if (widget.file != null) {
      image = Image.file(
        widget.file,
        fit: BoxFit.cover,
      );
    } else {
      image =
          Icon(Icons.person, color: ColorConstants.APP_THEME_COLOR, size: 65);
    }
    return image;
  }
}
