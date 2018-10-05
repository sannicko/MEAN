var mongoose = require('mongoose');
var UserQuoteSchema = new mongoose.Schema({
  name:  { type: String, required: true, minlength: 6},
  quote: { type: String, required: true},
}, {timestamps: true });
//store schema:
mongoose.model('UserQuote', UserQuoteSchema);
var UserQuote = mongoose.model('UserQuote');