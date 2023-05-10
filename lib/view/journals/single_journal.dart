import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../model/journal_model/journal_model.dart';
import 'edit_Journals.dart';


class SingleJournal extends StatefulWidget {
  const SingleJournal({Key? key, required this.journalModel}) : super(key: key);

  final JournalModel journalModel;

  @override
  State<SingleJournal> createState() => _SingleJournalState();
}

class _SingleJournalState extends State<SingleJournal> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      //width: size.width*.55,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1, color: Colors.blue)
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(widget.journalModel!.admirers["profile"], height: 40, width: 40, fit: BoxFit.cover,),
                              ),
                              SizedBox(width: 10,),
                              Text("${widget.journalModel!.admirers["name"]}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.keyboard_arrow_down, color: Colors.grey,)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          width: 30, height: 30,
                          decoration: BoxDecoration(
                              color: Color(widget.journalModel.color),
                              borderRadius: BorderRadius.circular(100)
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (contex)=>EditJournal(journalModel: widget.journalModel,))),
                            child: Icon(Icons.edit_outlined, size: 20, color: AppColors.white,)
                        ),
                      )
                    ],
                  ),

                ],
              ),

              SizedBox(height: 30,),
              Text("${widget.journalModel.title} ",
                 overflow: TextOverflow.clip,
                 style: TextStyle(
                      fontSize: 28,
                      color: AppColors.blue.withOpacity(0.8),
                      fontWeight: FontWeight.w600
                  )
              ),
              SizedBox(height: 20,),
              //Text(widget.journalModel.details),
              Html(
                data: "${widget.journalModel.details} ",
                onImageTap: (src, context, attributes, element) {
                  // Handle image tap if needed
                },
                // customRender: (node, children) {
                //   if (node is dom.Element && node.localName == 'img') {
                //     return Image.network(node.attributes['src'] ?? '');
                //   }
                // },
                //customRenders: base64ImageRender,
              )

            ],
          ),
        ),
      ),
    );
  }



}
