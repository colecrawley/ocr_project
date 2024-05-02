import easyocr as ocr

reader = ocr.Reader(['en'], model_storage_directory= '.')

result = reader.readtext('tester_image.png')

for text in result:
    print(text[1])