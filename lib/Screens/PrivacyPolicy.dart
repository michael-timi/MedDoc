import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meddoc/Screens/SignUp.dart';
import 'package:meddoc/Styles/applayout.dart';

import '../Styles/styles.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Padding(
        padding: EdgeInsets.only(top: 50,left: 22,right: 22),
        child: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Privacy Policy",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Effective Date: 2022-11-28", style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("1. Introduction", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(10),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome to MedDoc: Doctor Finder and Appointment App.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MedDoc: Doctor Finder and Appointment App (“us”, “we”, or “our”) operates MedDoc.com (hereinafter referred to as “Service”).", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify)
                    ],
                  ),Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Our Privacy Policy governs your visit to MedDoc.com, and explains how we collect, safeguard and disclose information that results from your use of our Service.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We use your data to provide and improve Service. By using Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, the terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Our Terms and Conditions (“Terms”) govern all use of our Service and together with the Privacy Policy constitutes your agreement with us (“agreement”).", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("2. Definitions", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SERVICE means the MedDoc.com website operated by MedDoc: Doctor Finder and Appointment App.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PERSONAL DATA means data about a living individual who can be identified from those data (or from those and other information either in our possession or likely to come into our possession).", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("USAGE DATA is data collected automatically either generated by the use of Service or from Service infrastructure itself (for example, the duration of a page visit).", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ), Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("COOKIES are small files stored on your device (computer or mobile device).", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DATA CONTROLLER means a natural or legal person who (either alone or jointly or in common with other persons) determines the purposes for which and the manner in which any personal data are, or are to be, processed. For the purpose of this Privacy Policy, we are a Data Controller of your data.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DATA PROCESSORS (OR SERVICE PROVIDERS) means any natural or legal person who processes the data on behalf of the Data Controller. We may use the services of various Service Providers in order to process your data more effectively.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DATA SUBJECT is any living individual who is the subject of Personal Data.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("THE USER is the individual using our Service. The User corresponds to the Data Subject, who is the subject of Personal Data.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("3. Information Collection and Use//left", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We collect several different types of information for various purposes to provide and improve our Service to you.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("4. Types of Data Collected", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                    Gap(20),
                    Row(//heading
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Personal Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                      ],
                    ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you (“Personal Data”). Personally identifiable information may include, but is not limited to:", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. Email address", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2. First name and last name", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3. Phone number, and Identification Card for Specialist", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("4. Address, Country, State, Province, and City", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("5. Cookies and Usage Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may use your Personal Data to contact you with newsletters, marketing or promotional materials and other information that may be of interest to you. You may opt out of receiving any, or all, of these communications from us by following the unsubscribe link.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Usage Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may also collect information that your browser sends whenever you visit our Service or when you access Service by or through any device (“Usage Data”).", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("This Usage Data may include information such as your computer’s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages, unique device identifiers and other diagnostic data.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("When you access Service with a device, this Usage Data may include information such as the type of device you use, your device unique ID, the IP address of your device, your device operating system, the type of Internet browser you use, unique device identifiers and other diagnostic data.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Location Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may use and store information about your location if you give us permission to do so (“Location Data”). We use this data to provide features of our Service, to improve and customize our Service.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You can enable or disable location services when you use our Service at any time by way of your device settings.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Tracking Cookies Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We use cookies and similar tracking technologies to track the activity on our Service and we hold certain information.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cookies are files with a small amount of data which may include an anonymous unique identifier. Cookies are sent to your browser from a website and stored on your device. Other tracking technologies are also used such as beacons, tags and scripts to collect and track information and to improve and analyze our Service.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Examples of Cookies we use:", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0.1. Session Cookies: We use Session Cookies to operate our Service.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0.2. Preference Cookies: We use Preference Cookies to remember your preferences and various settings.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0.3. Security Cookies: We use Security Cookies for security purposes.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("0.4. Advertising Cookies: Advertising Cookies are used to serve you with advertisements that may be relevant to you and your interests.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Other Data:", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("While using our Service, we may also collect the following information: sex, age, date of birth, place of birth, passport details, citizenship, registration at place of residence and actual address, telephone number (work, mobile), details of documents on education, qualification, professional training, employment agreements, NDA agreements, information on bonuses and compensation, information on marital status, family members, social security (or other taxpayer identification) number, office location and other data.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("5. Use of Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MedDoc: Doctor Finder and Appointment App uses the collected data for various purposes", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. to provide and maintain our Service", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2. to notify you about changes to our Service;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3. to allow you to participate in interactive features of our Service when you choose to do so;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("4. to provide customer support;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("5. to gather analysis or valuable information so that we can improve our Service;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("6. to monitor the usage of our Service;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("7. to detect, prevent and address technical issues;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("8. to fulfil any other purpose for which you provide it;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("9. to carry out our obligations and enforce our rights arising from any contracts entered into between you and us, including for billing and collection;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("10. to provide you with notices about your account and/or subscription, including expiration and renewal notices, email-instructions, etc.;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("11. to provide you with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless you have opted not to receive such information;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("12. in any other way we may describe when you provide the information;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("13. for any other purpose with your consent.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("6. Retention of Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We will retain your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period, except when this data is used to strengthen the security or to improve the functionality of our Service, or we are legally obligated to retain this data for longer time periods.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period, except when this data is used to strengthen the security or to improve the functionality of our Service, or we are legally obligated to retain this data for longer time periods.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("7. Transfer of Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your information, including Personal Data, may be transferred to – and maintained on – computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ from those of your jurisdiction.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("If you are located outside Philippines and choose to provide information to us, please note that we transfer the data, including Personal Data, to Philippines and process it there.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ), Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MedDoc: Doctor Finder and Appointment App will take all the steps reasonably necessary to ensure that your data is treated securely and in accordance with this Privacy Policy and no transfer of your Personal Data will take place to an organisation or a country unless there are adequate controls in place including the security of your data and other personal information.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("8. Disclosure of Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may disclose personal information that we collect, or you provide:", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("1. Disclosure for Law Enforcement.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Under certain circumstances, we may be required to disclose your Personal Data if required to do so by law or in response to valid requests by public authorities.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("2. Business Transaction.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("If we or our subsidiaries are involved in a merger, acquisition or asset sale, your Personal Data may be transferred.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("3. Other cases. We may disclose your\ninformation also:", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                 Gap(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3. to our subsidiaries and affiliates", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.start,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3.2. to contractors, service providers, and other third parties we use to support our business;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3.3. to fulfill the purpose for which you provide it;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3.4. for the purpose of including your company’s logo on our website;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),   Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3.5. for any other purpose disclosed by us when you provide the information;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ), Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3.6. with your consent in any other cases;", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3.7. if we believe disclosure is necessary or appropriate to protect the rights, property, or safety of the Company, our customers, or others.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("9. Security of Data", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("The security of your data is important to us but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("10. Service Providers", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may employ third party companies and individuals to facilitate our Service (“Service Providers”), provide Service on our behalf, perform Service-related services or assist us in analysing how our Service is used.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("These third parties have access to your Personal Data only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("11. Analytics", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may use third-party Service Providers to monitor and analyze the use of our Service.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("12. Behavioral Remarketing", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may use remarketing services to advertise on third party websites to you after you visited our Service. We and our third-party vendors use cookies to inform, optimise and serve ads based on your past visits to our Service.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("13. Children’s Privacy", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Our Services are not intended for use by children under the age of 18 (“Child” or “Children”).", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We do not knowingly collect personally identifiable information from Children under 18. If you become aware that a Child has provided us with Personal Data, please contact us. If we become aware that we have collected Personal Data from Children without verification of parental consent, we take steps to remove that information from our servers.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("14. Changes to This Privacy Policy", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update “effective date” at the top of this Privacy Policy.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ), Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Gap(20),
                  Row(//heading
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("20. Contact Us", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Gap(20),
                  Column(//text
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("If you have any questions about this Privacy Policy, please contact us by email: MedDocApp1@gmail.com.", style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.justify,)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15,top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Text("Decline",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.redAccent),),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=>SignUp()));
                          },
                          child: Text("Accept",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Styles.primaryColor),),
                        ),
                      ],
                    ),
                  ),















                ],
              ),
            )),

          ],
        ),
      )
    );
  }
}
