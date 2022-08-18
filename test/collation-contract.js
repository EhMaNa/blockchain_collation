/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { ChaincodeStub, ClientIdentity } = require('fabric-shim');
const { CollationContract } = require('..');
const winston = require('winston');

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const sinon = require('sinon');
const sinonChai = require('sinon-chai');

chai.should();
chai.use(chaiAsPromised);
chai.use(sinonChai);

class TestContext {

    constructor() {
        this.stub = sinon.createStubInstance(ChaincodeStub);
        this.clientIdentity = sinon.createStubInstance(ClientIdentity);
        this.logger = {
            getLogger: sinon.stub().returns(sinon.createStubInstance(winston.createLogger().constructor)),
            setLevel: sinon.stub(),
        };
    }

}

describe('CollationContract', () => {

    let contract;
    let ctx;

    beforeEach(() => {
        contract = new CollationContract();
        ctx = new TestContext();
        ctx.stub.getState.withArgs('1001').resolves(Buffer.from('{"value":"collation 1001 value"}'));
        ctx.stub.getState.withArgs('1002').resolves(Buffer.from('{"value":"collation 1002 value"}'));
    });

    describe('#collationExists', () => {

        it('should return true for a collation', async () => {
            await contract.collationExists(ctx, '1001').should.eventually.be.true;
        });

        it('should return false for a collation that does not exist', async () => {
            await contract.collationExists(ctx, '1003').should.eventually.be.false;
        });

    });

    describe('#createCollation', () => {

        it('should create a collation', async () => {
            await contract.createCollation(ctx, '1003', 'collation 1003 value');
            ctx.stub.putState.should.have.been.calledOnceWithExactly('1003', Buffer.from('{"value":"collation 1003 value"}'));
        });

        it('should throw an error for a collation that already exists', async () => {
            await contract.createCollation(ctx, '1001', 'myvalue').should.be.rejectedWith(/The collation 1001 already exists/);
        });

    });

    describe('#readCollation', () => {

        it('should return a collation', async () => {
            await contract.readCollation(ctx, '1001').should.eventually.deep.equal({ value: 'collation 1001 value' });
        });

        it('should throw an error for a collation that does not exist', async () => {
            await contract.readCollation(ctx, '1003').should.be.rejectedWith(/The collation 1003 does not exist/);
        });

    });

    describe('#updateCollation', () => {

        it('should update a collation', async () => {
            await contract.updateCollation(ctx, '1001', 'collation 1001 new value');
            ctx.stub.putState.should.have.been.calledOnceWithExactly('1001', Buffer.from('{"value":"collation 1001 new value"}'));
        });

        it('should throw an error for a collation that does not exist', async () => {
            await contract.updateCollation(ctx, '1003', 'collation 1003 new value').should.be.rejectedWith(/The collation 1003 does not exist/);
        });

    });

    describe('#deleteCollation', () => {

        it('should delete a collation', async () => {
            await contract.deleteCollation(ctx, '1001');
            ctx.stub.deleteState.should.have.been.calledOnceWithExactly('1001');
        });

        it('should throw an error for a collation that does not exist', async () => {
            await contract.deleteCollation(ctx, '1003').should.be.rejectedWith(/The collation 1003 does not exist/);
        });

    });

});
