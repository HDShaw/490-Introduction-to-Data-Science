# HW 7 - Due Monday Nov 13, 2017 in moodle and hardcopy in class. 
# Upload R file to Moodle with filename: HW7_490IDS_24.R
# Do not remove any of the comments. These are marked by #

### For this assignment will extract useful information from XML and 
### use Google Earth for data visualization. 
### The hw7.rda file containing the contry geographic coordinate is uploaded to Moodle.
### Look at detail instructions for the assignment in hw7_Intro.pdf.



### Part 1.  Create the data frame from XML file

### Functions you'll want to use: xmlParse(), xmlRoot(), xpathSApply(), xmlGetAttr().
### It also might make it easier to use: xmlToList(), merge().

### (a) Load the data frame called LatLon from hw7.rda. 
library("XML")
load("/Users/huidanxiao/Desktop/hw7.rda")
### (b) Download the gzipped XML factbook document from
### http://jmatchparser.sourceforge.net/factbook/
### and create an XML "tree" in R 
doc=xmlParse("/Users/huidanxiao/Desktop/factbook.xml")
print(doc)
tree=xmlRoot(doc)
tree
### (c) Use XPath to extract the infant mortality and the CIA country codes from the XML tree
path="//field[@name='Infant mortality rate']/rank"
col=c("number","country")
class(col)
sub_mortality_countrycode=sapply(col,function(var) xpathSApply(tree,path,function(x)xmlGetAttr(x,var)))
sub_mortality_countrycode

### (d) Create a data frame called IM using this XML file.
### The data frame should have 2 columns: for Infant Mortality and CIA.Codes.
IM=data.frame("Infant Mortality"=as.numeric(sub_mortality_countrycode[,"number"]),"CIA.Codes"=sub_mortality_countrycode[,"country"])
IM
### (e) Extract the country populations from the same XML document
### Create a data frame called Pop using these data.
### This data frame should also have 2 columns, for Population and CIA.Codes.
path="//field[@name='Population']/rank"
col=c("number","country")
sub_popu_code=sapply(col,function(var)xpathSApply(tree,path,function(x)xmlGetAttr(x,var)))
sub_popu_code
Pop=data.frame("Population"=as.numeric(sub_popu_code[,1]),"CIA.Codes"=sub_popu_code[,2])
Pop
### (f) Merge the two data frames to create a data frame called IMPop with 3 columns:
### IM, Pop, and CIA.Codes
IMPop=merge(IM,Pop,by="CIA.Codes")
### (g) Now merge IMPop with LatLon (from newLatLon.rda) to create a data frame called AllData that has 6 columns
### for Latitude, Longitude, CIA.Codes, Country Name, Population, and Infant Mortality
### (please check lat,long are not reversed in the file)
IMPop$CIA.Codes=toupper(IMPop$CIA.Codes)
AllData=merge(IMPop,LatLon)
summary(AllData)
AllData=AllData[,c("Latitude", "Longitude", "CIA.Codes", "Country.Name","Population", "Infant.Mortality")]
AllData
### Part 2.  Create a KML document for google earth visualization.
### Make the KML document with stucture described in hw7_Intro.pdf.  You can use the addPlacemark function below to make
### the Placemark nodes, for which you need to complete the line for the Point node and
### figure out how to use the function.

makeBaseDocument = function(){
### This code creates the template for KML document 
### Your code here
doc=newXMLDoc()
root=newXMLNode("kml",namespaceDefinitions="http://www.opengis.net/kml/2.2",doc=doc)
Document=newXMLNode("Document",parent=root)
newXMLNode("name","Country Facts",parent=Document)
newXMLNode("Description","Infant mortality",parent=Document)
LookAt=newXMLNode("LookAt",parent=Document)
newXMLNode("lontitude","-121",parent=LookAt)
newXMLNode("latitude","43",parent=LookAt)
newXMLNode("altitude","4100000",parent=LookAt)
newXMLNode("title","0",parent=LookAt)
newXMLNode("heading","0",parent=LookAt)
newXMLNode("altitudeMode","absolute",parent=LookAt)
Folder=newXMLNode("Folder",parent=Document)
newXMLNode("name","CIA Fact book",parent=Folder)
return(doc)
}

addPlacemark = function(lat, lon, ctryCode, ctryName, pop, infM, parent, 
                        inf1, pop1, style = FALSE)
{
  pm = newXMLNode("Placemark", 
                  newXMLNode("name", ctryName), attrs = c(id = ctryCode), 
                  parent = parent)
  newXMLNode("description", paste(ctryName, "\n Population: ", pop, 
                                  "\n Infant Mortality: ", infM, sep =""),
             parent = pm)

  newXMLNode("Point",newXMLNode("coordinates",paste(lon,lat,0,sep=",")),parent=pm)
             
### You need to fill in the code for making the Point node above, including coordinates.
### The line below won't work until you've run the code for the next section to set up
### the styles.

  if(style) newXMLNode("styleUrl", paste("#YOR", inf1, "-", pop1, sep = ''), parent = pm)
}


### Use the two functions that you just implemented to created the KML document and save it 
### as 'Part2.kml'. open it in Google Earth. (You will need to install Google Earth.)  
### It should have pushpins for all the countries.  

### Your code here
doc1=makeBaseDocument()
root1=xmlRoot(doc1)
parentNode=root1[["Document"]]["Folder"]
for(i in 1:length(AllData$Latitude)){
  addPlacemark(lat=AllData$Latitude[i], lon=AllData$Longitude[i], 
               ctryCode=AllData$CIA.Codes[i],ctryName=AllData$Country.Name[i], 
               pop=AllData$Population[i], infM=AllData$Infant.Mortality[i], parent=parentNode)
}

saveXML(root1,file="Part2.kml")

### Part 3.  Add Style to your KML
### Now you are going to make the visualizatiion a bit fancier. To be more specific, instead of pushpins, we
### want different circle labels for countris with size representing population and the color representing  
### the infant motality rate.
### Pretty much all the code is given to you below to create style elements.
### Here, you just need to figure out what it all does.

### Start fresh with a new KML document, by calling makeBaseDocument()

doc2 = makeBaseDocument()

### The following code is an example of how to create cut points for 
### different categories of infant mortality and population size.
### Figure out what cut points you want to use and modify the code to create these 
### categories.
infCut = cut(as.numeric(AllData[,2]), breaks = quantile(as.numeric(AllData[,2]),seq(0,1,length=6),include.lowest=TRUE,na.rm=TRUE))
infCut = as.numeric(infCut)
popCut = cut(as.numeric(AllData[,3]), breaks = quantile(as.numeric(AllData[,3]),seq(0,1,length=6),include.lowest=TRUE,na.rm=TRUE))
popCut = as.numeric(popCut)

### Now figure out how to add styles and placemarks to doc2
### You'll want to use the addPlacemark function with style = TRUE
### Below is code to make style nodes. 
### You should not need to do much to it.

### You do want to figure out what scales to use for the sizes of your circles. Try different 
### setting of scale here.
#Try your scale here for better visualization

scale = c(1,3,5,8,10)
colors = c("blue","green","yellow","orange","red")

addStyle = function(col1, pop1, parent, DirBase, scales = scale)
{
  st = newXMLNode("Style", attrs = c("id" = paste("YOR", col1, "-", pop1, sep="")), parent = parent)
  newXMLNode("IconStyle", 
             newXMLNode("scale", scales[pop1]), 
             newXMLNode("Icon", paste(DirBase, "color_label_circle_", colors[col1], ".png", sep ="")), parent = st)
}


root2 = xmlRoot(doc2)
DocNode = root2[["Document"]]


for (k in 1:5)
{
  for (j in 1:5)
  {
    addStyle(j, k, DocNode, 'color_label_circle/')
  }
}

### You will need to figure out what order to call addStyle() and addPlacemark()
### so that the tree is built properly. You may need to adjust the code to call the png files
### Your code here
new_doc_node=root2[["Document"]]["Folder"]
for (i in 1:length(AllData$Latitude)){
  addPlacemark(lat=AllData$Latitude[i], lon=AllData$Longitude[i], 
               ctryCode=AllData$CIA.Codes[i],ctryName=AllData$Country.Name[i], 
               pop=AllData$Population[i], infM=AllData$Infant.Mortality[i], parent=new_doc_node,
               inf1=infCut[i],pop1=popCut[i],style=TRUE)
}


### Finally, save your KML document, call it Part3.kml and open it in Google Earth to 
### verify that it works.  For this assignment, you only need to submit your code, 
### nothing else.  You can assume that the grader has already loaded hw7.rda.
saveXML(doc2,file="/Users/huidanxiao/Desktop/Part3.kml")

