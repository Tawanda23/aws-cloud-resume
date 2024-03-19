import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('cloudresume-new')

def lambda_handler(event, context):
    try:
        response = table.get_item(Key={'id': '0'})
        item = response.get('Item')  # get()handles cases where 'Item' key is not present
        if item:
            views = item.get('views')  #get() used to handle sceanrios where 'views' key is not present
            if views is not None:  
                views += 1
                table.put_item(Item={'id': '0', 'views': views})
                return views
            else:
                return "Views attribute not found"
        else:
            return "Item not found"
    except Exception as e:
        return str(e)
